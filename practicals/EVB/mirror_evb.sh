#! /bin/bash

###################USER_VARIABLES###################################
#Q SOFTWARE
qdyn=qdyn

#ZIP WHEN DONE?
zip_after=true

#SET TEMPERATURES TO SIMULATE:
temperatures=(298)
#temperatures=(288 293 298 303 308)

#SET NUMBER OF RUNS:
runs=10

#START SUBMITTING JOBS FROM:
start_from=1

#NAME OF CLUSTER SPECIFIC SUBMISSION SCRIPT (STORED IN $inputfiles)
submit_script="run.sh"

#CLUSTER SPECIFIC SUBMIT COMMAND
submit_command="sbatch"

#YOU ARE WORKING HERE:
home_path=$(pwd)

#INPUTFILES ARE EXISTING IN $home_path/$inputfiles WITH THIS NAME:
inputfiles="inputfiles"

#MIRROR JOBS FROM ../$mirror_from/../$home_path/  (--> /inputfiles)
mirror_from="$USER"

#JOBS WILL BE MIRRORED TO work_path/../$home_path/ (--> /inputfiles)
work_path="/cluster/work/users/$USER/nodelete"

#JOB LOG FILE WITH TIMESTAMP
job_info="job_"`date +%Y-%m-%d_%H-%M`".txt"
###########################END######################################
####################################################################

##########################SCRIPT####################################

#CHECK IF /inputfiles EXISTS
if [ -d "$home_path/$inputfiles" ];
then
    printf "\nFound $inputfiles directory\n"
else
    printf "\nCould not find $inputfiles directory. ABORTING!\n"
    exit 1
fi


#GET PATH TO CREATE FROM  home_path + mirror_from:
IFS='/' read -ra path_array <<< "$home_path"

found_mirror=false
for i in "${path_array[@]}"
do
    if $found_mirror;
    then
        work_path="$work_path/$i"
    
    fi

    if [ "$i" = "$mirror_from" ];
    then
        found_mirror=true 
    fi
done

printf  "\nJobs from:\n $home_path \nwill be submitted from:\n $work_path \n\n"

#CREATE $work_path if it does not exist
mkdir -p $work_path

#COPY $home_path/$inputfiles to $work_path
cp -r "$home_path/$inputfiles/" "$work_path"

#Move to $work_path
cd $work_path


#Iterate over temperatures
for temp in ${temperatures[*]}
do

    #Create temperature directory if it does not exist
    if [ ! -d "$temp" ]; then
        mkdir -p $temp
    fi

    cd $temp

    #iterate over runs
    for i in $(seq $start_from $runs)
    do

        #Create run directory if it does not exist
        if [ ! -d "$i" ]; then
            mkdir -p $i
        fi

        cd $i

        #copy inpufiles to run directory:
        cp ../../inputfiles/* .

        #Set temperature in MD inputfiles:
        sed -i s/T_VAR/"$temp"/ *.inp

        #Get a random seed
        seed="$((1 + (RANDOM % 9999)))"

        #Insert seed into MD file by replacing SEED_VAR in file with $seed
        sed -i s/SEED_VAR/"$seed"/ *.inp

        #Write job path and seed back to $home_path
        echo "$work_path/$temp/$i SEED_VAR: $seed" >> "$home_path/$inputfiles/$job_info"

        #Append temperature and run to --job-name of run.sh
        sed -i /job-name/s/$/_"$temp"-"$i"/ run.sh 

        #Delete existing qfep.out (if it exist)
        if [ -f qfep.out ]; then
            rm qfep.out
        fi

        #Submit job (f.ex: sbatch run.sh):
        $submit_command $submit_script

        cd ../
    done
    cd ../
done

#ZIP $home_path/$inputfiles WHEN DONE? 
if $zip_after;
then
	printf "\nZipping input files\n"
	cd $home_path
	zip -qr ${inputfiles}.zip $inputfiles
        #rm -r $inputfiles
else
	printf "\nNot zipping input files\n"
fi
exit 1

