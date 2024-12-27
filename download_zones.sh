#!/bin/bash
# coder: laudarch
# copyright: Tactical Intelligence Security (https://taise.tech)
# license: OpenBSD

# Define the base URL
base_url="http://www.ipdeny.com/ipblocks/data/countries/"

# Create the zones directory if it does not exist
mkdir -p zones

# List of all countries in the world
countries=(
"af" "al" "dz" "ad" "ao" "ag" "ar" "am" "au" "at"
"az" "bs" "bh" "bd" "bb" "by" "be" "bz" "bj" "bt"
"bo" "ba" "bw" "br" "bn" "bg" "bf" "bi" "cv" "kh"
"cm" "ca" "cf" "td" "cl" "cn" "co" "km" "cg" "cr"
"hr" "cu" "cy" "cz" "cd" "dk" "dj" "dm" "do" "tl"
"ec" "eg" "sv" "gq" "er" "ee" "sz" "et" "fj" "fi"
"fr" "ga" "gm" "ge" "de" "gh" "gr" "gd" "gt" "gn"
"gw" "gy" "ht" "hn" "hu" "is" "in" "id" "ir" "iq"
"ie" "il" "it" "ci" "jm" "jp" "jo" "kz" "ke" "ki"
"kw" "kg" "la" "lv" "lb" "ls" "lr" "ly" "li" "lt"
"lu" "mg" "mw" "my" "mv" "ml" "mt" "mh" "mr" "mu"
"mx" "fm" "md" "mc" "mn" "me" "ma" "mz" "mm" "na"
"nr" "np" "nl" "nz" "ni" "ne" "ng" "kp" "mk" "no"
"om" "pk" "pw" "ps" "pa" "pg" "py" "pe" "ph" "pl"
"pt" "qa" "ro" "ru" "rw" "kn" "lc" "vc" "ws" "sm"
"st" "sa" "sn" "rs" "sc" "sl" "sg" "sk" "si" "sb"
"so" "za" "kr" "ss" "es" "lk" "sd" "sr" "se" "ch"
"sy" "tw" "tj" "tz" "th" "tg" "to" "tt" "tn" "tr"
"tm" "tv" "ug" "ua" "ae" "gb" "us" "uy" "uz" "vu"
"va" "ve" "vn" "ye" "zm" "zw"
)

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <country_code|all>"
    exit 1
fi

input_code="$1"

# Function to download country files
download_country() {
    local country="$1"
    url="${base_url}${country}.zone"
    echo "Downloading: $url"
    wget -P zones "$url"
}

# If the input is "all", download all country files
if [ "$input_code" == "all" ]; then
    for country in "${countries[@]}"; do
        download_country "$country"
    done
else
    # Check if the input code is valid
    if [[ " ${countries[*]} " == *" $input_code "* ]]; then
        download_country "$input_code"
    else
        echo "Invalid country code: $input_code"
        echo "Please provide a valid two-letter country code or 'all'."
        exit 1
    fi
fi