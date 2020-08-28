"""MASTERMIND"""

from random import randint                  #generator of our secret code

def mastermind(columns=4, colors=4, rounds=12):         #our colors will be numbers
                                                        #defaults values, could be changed for more difficulty
    round = 1
    secret_code = [str(randint(1,colors)) for i in range(columns)]       #code generation
    print("Welcome to MASTERMIND\nFind a code of",columns, "digits corresponding to colors between 1 and",colors, end="") ; print(". Good luck!")

    while True:
        code = secret_code.copy()                               #code will be modified, but we don't want secret_code to be modified
        player_choice = list(input("Round "+str(round)+":"))    #player is invited to guess the code

        if len(player_choice) == 0:                             #just in case player surrenders
            print("You choose to quit :'( The code was:","".join(secret_code), end="") ; print(". See you!")
            break

        round += 1
        good_color_and_position = 0
        good_color_wrong_position = 0

        for i,v in enumerate(player_choice):
            if v == code[i]:                            # look at good colors in good position
                good_color_and_position += 1
                player_choice[i] = "X"                  # remove from player choice what has already been counted to avoid recounting it
                code[i] = "x"                           # remove from secret_code what has already been counted to avoid recounting it

        if good_color_and_position == columns:                                          # when|if player find secret_code
            print("Well done! The code was indeed:","".join(secret_code), end="") ; print(". See you!")
            break

        for i,v in enumerate(player_choice):            # look at good colors in wrong position
            if v in code :
                good_color_wrong_position += 1
                code[code.index(v)] = "x"               # remove from secret_code what has already been counted to avoid recounting it

        print("Good color and position:", good_color_and_position, "\nGood color wrong position:", good_color_wrong_position)

        if round > rounds:                              # if player didn't guess before max rounds
            print("You were unable to guess the exact pattern within the given number of turns.\nThe code was:","".join(secret_code), end="") ; print(". See you!")
            break

mastermind()