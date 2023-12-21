#function to ask if the user want to play again??

function play_again {

	read -p "Do you want to play again? (yes /no): " answer
        check=$(check_input "$answer")

        while [ "$check" == false ]; do

                echo "You entered an invalid answer: $response"

                read -p "Please enter a valid answer? (yes/no): " answer

                check=$(check_input "$answer")

        done
	echo "$answer"
}

# Function to make the computer choose a random number each round
function random_num {
    echo $((1 + RANDOM % 100))
}

# Function to check if the number that the player wants to guess is Even, Odd, or Prime
function the_first_mean {

    local input=$1

    local counter=0
    
    for ((i=2; i<=$input/2; i++)); do

        if [ $((input % i)) == 0 ]; then
            ((counter++))
            break
        fi
    done

    if [ $counter == 0 ]; then
        echo "Prime"
    elif [ $((input % 2)) == 0 ]; then
        echo "Even"
    else
        echo "Odd"
    fi
}

# Function to check if a number is within a range
function the_second_mean {

    local num=$1
    local range_start=$2
    local range_end=$3

    if [ $num -ge $range_start ] && [ $num -le $range_end ]; then
        echo "yes"
    else
        echo "no"
    fi
}



# Function to check if the input is valid
function check_input {

    local input=$1
    local valid=false

    for ans in "${answers[@]}"; do
        if [ "$input" == "$ans" ]; then
            valid=true
            break
        else

            valid=false
        fi
    done

    echo $valid
}



# Starting the game
echo "Hello in our Guessing game :)"

# Valid answers
answers=("no" "yes")

check=false

read -p "Do you want to play with us? (yes/no): " answer



# Check if the user input is a valid answer or not
check=$(check_input "$answer")

while [ "$check" == false ]; do
    echo "You entered an invalid answer: $answer"
    read -p "Please enter a valid answer? (yes/no): " answer

    # Reset check based on the new input
    check=$(check_input "$answer")
done

if [ "$answer" == "no" ]; then

    echo -e "Thanks for you, Bye Bye \U1F44B "

    exit 1

else

    user_score=0

    computer_score=0

    user_chances=7

    number_of_means=2



    intro="I'm so so happy that you want to play ❤

Now, Let me explain the game to you

Our game called Guessing game 🤔

From the name, your brain will do very hard work in guessing 😂😂

The game is that the computer will choose a number from 1 to 100

and your job is to guess the number that the computer chooses

and you have only 7 chances to get the number

and you will take 2 Auxiliary means and you can use them after the first chance

The First one:-

   I will tell you if the number is Odd or Even or Prime

   and this will increase your opportunity to get the number.

The Second one:-

   you will give me two numbers. I will tell you 'yes' if the number that the computer chose is between them, otherwise, I will tell you 'no'

And you can also use the same mean in your 2 chances

and if you want to stop, enter the -stop- word

BE Worry!!!!!!!!! if you enter any characters or strings instead of the guessed number, this will decrease your chances

Be sure that you enter a valid value

***************************************************** "



    echo -e "$intro"

    read -p "Please press Enter to start.........."



    computer_choose=$(random_num)



    while true; do

        echo "Your Score is $user_score

Compute score is $computer_score"



        if [ $user_chances -le 6 ] && [ $number_of_means -gt 0 ]; then

            read -p "Do you want to use one of your means? (yes/no): " response

            check=$(check_input "$response")



            while [ "$check" == false ]; do

                echo "You entered an invalid answer: $response"

                read -p "Please enter a valid answer? (yes/no): " response

                check=$(check_input "$response")

            done



            if [ "$response" == "yes" ]; then

                echo "Okay you have $number_of_means Auxiliary means

What do you want to use ?

If you want to know if the number is Even or Odd or Prime enter 1

If you want to give me two numbers to check if the number is in the range, enter 2"



                # Input validation loop

                while true; do

                    read -p "Enter your choice (1 or 2): " want

                    if [ "$want" == 1 ] || [ "$want" == 2 ]; then

                        break  # Exit the loop if a valid choice is entered

                    else

                        echo "Invalid input. Please enter 1 or 2."

                    fi

                done



                if [ "$want" == 1 ]; then

                    res=$(the_first_mean "$computer_choose")

                    echo "The number you try to guess is $res"

                elif [ "$want" == 2 ]; then

                    read -p "Enter the first num: " num1

                    read -p "Enter the second num: " num2

                    res=$(the_second_mean "$computer_choose" "$num1" "$num2")

                    echo "Is the number in the range?

The answer is: $res"

                fi



                number_of_means=$((number_of_means - 1))

            fi

        fi



        read -p "Guess a number: " guess



        if [ "$guess" == "stop" ]; then

            echo "Thank you for playing!"

            exit 1

        else

            if [ "$guess" -eq "$computer_choose" ]; then

                ((user_score++))

                echo "Congratulations 🎉 You succeeded in guessing the number!

Now your score is $user_score

Computer score is $computer_score"

		ask=$(play_again)

		if [ "$ask" == "yes" ]; then

			continue

		else

			break

		fi

                break

            else

                ((user_chances--))

                if [ "$user_chances" -eq 0 ]; then

                    ((computer_score++))

                    echo "You have used all of your chances!

Game Over..

And the computer wins ☠

Now your score is $user_score

Computer score is $computer_score"

                ask=$(play_again)

                if [ "$ask" == "yes" ]; then

                        continue

                else

                        break

                fi



                else

                    echo "Ohbs!

Your guess is not correct :(

Now you have only $user_chances chances

Come on you can do it 🏌️‍♂️, And I will help you"



                    if [ "$guess" -gt "$computer_choose" ]; then

                        echo "The number is big. Guess a smaller number"

                    else

                        echo "The number is small. Guess a bigger number"

                    fi

                fi

            fi

        fi

    done

fi



echo "Thank you for playing!"

