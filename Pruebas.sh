#!/bin/bash

prueba1 () {
    txtEditor=$(ps -ef | grep editor | grep -v grep)
    slack=$(ps -ef | grep slack | grep -v grep)
    vscode=$(ps -ef | grep code | grep -v grep)

    array=("$txtEditor" "$slack" "$vscode")

    for prg in "${array[@]}"; do
        if [[ -z $prg ]]; then echo "Uno de los programas no está corriendo."; fi
    done

    echo "Todos los programas están activos."
}


# prueba2 ()
# {
    
# }

prueba3 ()
{
    useradd Hacker
    su Hacker -c "ping 8.8.8.8 &" > Hckr.txt
}

# prueba4 ()
# {
    
# }

# prueba5 ()
# {
    
# }