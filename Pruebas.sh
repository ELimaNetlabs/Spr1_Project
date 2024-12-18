#!/bin/bash

prueba1 () {
    echo $1
    echo "Slack, Editor de texto y VSCode"
	sleep 1
	echo "Corre el tiempo"

    for ((i = 1; i<11; i++ )); do
		echo "$i"
		sleep 1
	done

    txtEditor=$(ps -ef | grep editor | grep -v grep)
    slack=$(ps -ef | grep slack | grep -v grep)
    vscode=$(ps -ef | grep code | grep -v grep)

    array=("$txtEditor" "$slack" "$vscode")

    algunoCerrado=0
    for prg in "${array[@]}"; do
        if [[ -z $prg ]]; then algunoCerrado=1; fi
    done
    
    if [[ $algunoCerrado -eq 1 ]]; then prueba1 "Parece que no lo lograste, intentemos de nuevo"; fi
}


# prueba2 ()
# {
    
# }

prueba3 ()
{
    useradd Hacker
    su Hacker -c "ping 8.8.8.8 &" > .Hckr.txt
}

# prueba4 ()
# {
    
# }
