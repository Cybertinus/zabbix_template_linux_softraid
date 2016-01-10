#!/bin/bash

# Copyright (c) 2016, Tijn Buijs
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the <organization> nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
#DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Function to show how this script should be used
function usage() {
        echo "Usuage: $0 raid-device informationpart

eg. $0 md0 State"
}

# Check if $1 is specified, if not tell the user how to use this program and exit
if [ -z "${1}" ] ; then
        echo 'Forget to specify the RAID device.' 1>&2
        echo ''
        usage
        exit 1
# Check if $2 is specified, if not tell the user how to use this program and exit
elif [ -z "${2}" ] ; then
        echo 'Forget to specify the piece of information you are looking for.' 1>&2
        echo ''
        usage
        exit 2
fi

# Check if the devicename starts with /dev/. If not, add it
if [ "${1:0:5}" = "/dev/" ] ; then
        device=$1
else
        device="/dev/${1}"
fi

# Parse the rest of the arguments as the name of the field the user is interessted in
shift
# Make sure all the words are initcap and the rest is lowercase
infopart=$(echo $@ | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) tolower(substr($i,2)) }}1')
# Count the number of words specified
wordsspecified=$(echo $infopart | wc -w)
# Add 2, to the words specified, because there the value of the requested field is found
awkfield=$(($wordsspecified + 2))
awkfieldaddone=$(($awkfield + 1))
awkfieldaddtwo=$(($awkfield + 2))

# Run the actual command to show the requested info
/sbin/mdadm --detail $device | grep "${infopart} :" | awk "{print \$${awkfield}\$${awkfieldaddone}\$${awkfieldaddtwo}}"
