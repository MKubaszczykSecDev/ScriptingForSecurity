#!/bin/bash



#------------------------------------------------------------------------------------------------------------------------------------------>



#filesearch_awk function. The function displays a text box and the user to input either veggies.csv or fruit.csv. 
#If the user selects cancel, the script quits. If veggies.csv is typed, an awk command runs which takes the second column in the file,
#and save the output as a variable. The line below the variable will display a new box containing the output, once user clicks "ok', 
#the script restarts back to function "start' - instruction 2.1
#If user types anything else other than veggies.csv or fruit.csv, the user will be prompted again (function restarts/called again).

filesearch_awk() {
    FILENAME=$(whiptail --title "AWK selected!" --inputbox "Enter the name of a file (veggies.csv or fruit.csv):" 10 70 3>&1 1>&2 2>&3)

if [ $? -ne 0 ]; then
        echo "User cancelled."
        return

fi

case $FILENAME in "veggies.csv")
        echo "User selected 'veggies.csv'"
        RESULT=$(awk -F ',' '{print $2}' $FILENAME)
	whiptail --title "Result" --msgbox "Values in the second column of 'veggies.csv':\n$RESULT" 11 70
	start
	;;
        "fruit.csv")
        echo "User selected 'fruit.csv'"
	RESULT=$(awk -F ',' '{print $2}' $FILENAME)
        whiptail --title "Result" --msgbox "Values in the 2nd column of 'fruit.csv':\n$RESULT" 11 70
	start
        ;;
        *)
        echo "User typed invalid file name, retrying...."
        filesearch_awk 
esac

}



#-----------------------------------------------------------------------------------------------------------------------------------------------------------



#filesearch_grep function. The function displays a text box and the user to input either veggies.csv or fruit.csv. 
#If the user selects cancel, the script quits. If veggies.csv is typed, the script will search for letter 'e" in the file,
#and save the output as a variable. The line below the variable will display a new box containing the output, once user clicks "ok', 
#the script restarts back to function "start' - instruction 2.1
#If user types anything else other than veggies.csv or fruit.csv, the user will be prompted again (function restarts/called again).

filesearch_grep() {
    FILENAME=$(whiptail --title "GREP selected!" --inputbox "Enter the name of a file (veggies.csv or fruit.csv):" 10 70 3>&1 1>&2 2>&3)

if [ $? -ne 0 ]; then
	echo "User cancelled."
        return

fi

case $FILENAME in "veggies.csv")
        echo "User selected 'veggies.csv'"
	RESULT=$(grep e /home/debian/scripting/Whiptail/veggies.csv  | head -4)
	whiptail --title "Result" --msgbox "Lines containing letter 'e' in 'veggies.csv':\n$RESULT" 11 70
	start
        ;;
        "fruit.csv")
        echo "User selected 'fruit.csv'"
        RESULT=$(grep e /home/debian/scripting/Whiptail/fruit.csv  | head -4)
        whiptail --title "Result" --msgbox "Lines containing letter 'e' in 'fruit.csv':\n$RESULT" 11 70
        start
        ;;
        *)
        echo "User typed invalid file name, retrying...."
	filesearch_grep 
esac

}



#------------------------------------------------------------------------------------------------------------------------------------------>



#This function displays a menu with 2 options, awk and grep, if the user selects awk, function filesearch_awk will be called.
#If the user selects grep, function filesearch_grep will be called. If user selects anything else, (cancel) the script will exit.

awk_or_grep() {
USER=$(whiptail --title "Main Menu" --menu "Would you like to use AWK or GREP or Quit?" 10 70 2 \
"AWK" "Search file using AWK." \
"GREP" "Search file using GREP." \
3>&1 1>&2 2>&3)

case $USER in "AWK")
	echo "User selected AWK"
	filesearch_awk
	;;
	"GREP")
	echo "User selected GREP"
	filesearch_grep
	;;
	*)
	echo "User cancelled or close the menu"	
esac

}



#------------------------------------------------------------------------------------------------------------------------------------------>



#Start function. Its for instruction 2.1, it asks the user if they want to continue with the script or exit.

start(){
if whiptail --title "Confirmation Required" --yesno "Would you like to continue? " 10 70; then
        awk_or_grep
else
        echo "Exiting...."
        exit 0
fi
}



#------------------------------------------------------------------------------------------------------------------------------------------>



#Starts the script by calling 'start" function
start
