#!/bin/bash

banner ()
{
        echo "
          _   _   _   _   _   _   _   _   _   _     _   _   _   _   _   _     _   _   _   _   _   _  
         / \ / \ / \ / \ / \ / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \ 
        ( E | m | i | l | i | a | n | o | ' | s ) ( A | S | C | C | I | I ) ( P | u | z | z | l | e )
         \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ 
        "
}

menu () 
{
        echo "Quiere empezar el puzzle? s/n"
        read op
        op=${op,,}
        if [[ "$op" != "s" && "$op" != "n" ]]; then
                echo "Opcion no valida"
                sleep 1
                clear
                banner
                menu
        else
                if [[ "$op" == "s" ]]; then
                        clear
                        banner
                        echo "Indique su nombre:"
                        read nombre
                        sleep 0.5
			pruebaDelDigno $nombre

                else
                        echo "Hasta luego..."
                        sleep 1
                        clear
                fi

        fi
}

controlesManual ()
{
        clear
        banner
        echo "
        CONTROLES
        Hola $1, estos son los controles para interactuar con el puzzle:
        -Para seleccionar la pieza a mover lo puede hacer con los numeros del 1 al 4.
        -Una vez seleccionada la pieza elija un numero del 1 al 4 para indicar cuantas veces desea girar la pieza indicada.
        -Es relevante saber que solo se puede girar la pieza del nive actual.
        "
        sleep 10
}

