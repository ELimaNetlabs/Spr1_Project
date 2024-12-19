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


prueba2 ()
{
    case $1 in
        "Mañana")
            if [[ -z $2 ]]; then

                echo "Veo que decidiste hacer el puzzle tempranito."
                echo "Como es temparno vamos a hacer una prueba para agilizar un poco la mente."
                echo "Vas a tener que crear un patron de numeros siguiendo esta regex: ^\d{2,3}-\d{2,3}-\d{2,3}$"
            else
                echo $2
                echo "regex: ^\d{2,3}-\d{2,3}-\d{2,3}$"
            fi

            echo "Patron:"
            read p
            
            if [[ $p =~ ^[0-9]{2,3}-[0-9]{2,3}-[0-9]{2,3}$ ]]; then 
                echo "Muy bien, parece que estas lo suficientemente despierto para poder seguir."
            else 
                prueba2 "Mañana" "Intenta despertar un poco mas tu mente. Intentalo de nuevo."
            fi
            ;;
        "Tarde")
            if [[ -z $2 ]]; then

                echo "En la tarde es donde estamos mas despiertos asi que es un excelente momento para hacer el puzzle"
                echo "Como es de tarde y tenes que estar bien despierto a esta altura..."
                echo "Vas a tener que adivinar a que esta asociada esta regex: (?i)^[a-zA-Z0-9._-]+@(gmail|hotmail)\.com$"
            else
                echo $2
                echo "regex: (?i)^[a-zA-Z0-9._-]+@(gmail|hotmail)\.com$"
            fi

            echo "A que esta asociada?"
            read a

            if [[ $a =~ (correo|electronico|mail|direccion) ]]; then 
                echo "Perfecto, vamos a seguir con el puzzle."
            else 
                prueba2 "Tarde" "Es muy facil, presta mucha atencion en la REGEX."
            fi
            ;;
        "Noche")
            if [[ -z $2 ]]; then

                echo "Se supone que en la noche la gente es mas creativa asi que esta prueba va de eso."
                echo "Quiero que crees una frase pero siguiendo estas condiciones:"
            else
                echo $2
            fi

            echo "-Empieze con S"
            echo "-Tenga . al final"
            echo "-Termine con la frase "del perro""
            echo "-Tenga un numero de 3 digitos"
            echo "Recomiendo que la frase tenga algo de coherencia para mayor diversion."
            read f
            echo $f

            if [[ $f =~ ^S.+[0-9]{3}.+del\ perro\.$ ]]; then 
                echo "Parece que cumpliste con lo que te pedi, muy bien,continuemos con el puzzle."
            else 
                prueba2  "Noche" "Se que ya puede ser tarde pero vamos, vos podes."
            fi
            ;;
        *)
            echo "Tiempo invalido."
            ;;
    esac
}

prueba3 ()
{
    useradd Hacker
    su Hacker -c "ping 8.8.8.8 &" > .Hckr.txt
}

prueba4 ()
{
    yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=ADGFuE7T8Qc&ab_channel=agustin4100" &> /dev/null
    archivo=$(ls -a | grep -E '^\.H.*r\..{3}$')
    cantLineas=$(cat $archivo | wc -l)
    tipoArchivo=$(file $archivo)
    flag=0
    
	while ([ $flag -eq 0 ])
	do
		echo "Cantidad de lineas:"
		read cl
		echo "Tipo de archivo:"
		read ta

        if [[ $cl -eq $cantLineas && $ta == $tipoArchivo ]]; then 
            flag=1 
            
            
        else echo "Intetalo de nuevo, estas cerca."; fi
        
	done


}
