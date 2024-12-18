#!/bin/bash
source ./Functions.sh
source ./Pruebas.sh

nombreJugador="No hay nadie jugando"
nivelActual=4;
pieza=('\' '|' '/' '-')
puzzle=()

cargarPuzzle ()
{
	for ((i = 0; i<4; i++ )); do
        n=$((RANDOM % 3))
        puzzle+=("${pieza[$n]}")
	done
}

pruebaDelDigno ()
{
	clear 
	banner
	
	if [[ -z $2 ]]; then
		nombreJugador=$1
		echo "Bienvenid@ $nombreJugador, antes de iniciar tendras que responder 4 preguntas, para verificar si realmente eres dign@ del puzzle..."
		sleep 3
	else
		echo $2
	fi
	
	echo "1-Qué diferencia existe entre el kernel de Linux y una distribución de Linux?"
	read r1
	echo "2-Que distribuciones de linux son las mas usadas para ciber seguridad?"
	read r2
	echo "3-Como influyo la filosofia del software libre en la creacion y evolucion de GNU/Linux?"
	read r3
	echo "4-Como se usa un pipe (|) para pasar el stdout de ls como stdin para grep?"
	read r4

	#DAR MAS COMPLEJIDAD
	pr1='(kernel|distribución|núcleo|sistema operativo|paquetes|control de hardware|software adicional)'
	pr2='(Kali Linux|Parrot OS|Arch|Pentesting|Ciberseguridad|Hacking ético)'
	pr3='(libertad|acceso al código|modificación|distribución libre|copiar|GPL|Richard Stallman|Proyecto GNU|comunidad)'
	pr4='(pipe|stdout|stdin|ls|grep|redirección|filtrado|conectar)'

	echo "Verificando respuestas..."
	sleep 0.5
	if [[ ! $r1 =~ $pr1 ]]; then
		echo "No eres lo suficientemente dign@, fallaste en la primera, esto sin duda no es lo tuyo."
		sleep 4
		pruebaDelDigno $1 "Intentemos nuevamente, intenta pasar de la 1 esta vez."
	elif [[ ! $r2 =~ $pr2 ]]; then
		echo "No eres lo suficientemente dign@, fallaste en la segunda, alguien tiene que estudiar mas...."
		sleep 4
		pruebaDelDigno $1 "Intentemos nuevamente, espero que estes mas preparado esta vez."
	elif [[ ! $r3 =~ $pr3 ]]; then
		echo "No eres lo suficientemente dign@, fallaste en la tercera, quiza puedas intentarlo una vez mas."
		sleep 4
		pruebaDelDigno $1 "Intentemos nuevamente, respira y.....RESPONDE BIEN."
	elif [[ ! $r4 =~ $pr4 ]]; then
		echo "No eres lo suficientemente dign@, fallaste en la cuarta, INTENTALO DE NUEVO YA CASI ESTAS."
		sleep 4
		pruebaDelDigno $1 "Intentemos nuevamente, STAY FOCUS."
	else
		echo "Excelente, ahora vamos al verdadero desafio."
		echo "Cargando puzzle..."
		sleep 1
		clear
		banner
		controlesManual $nombreJugador
		iniciar
	fi

	
}

iniciar ()
{
	echo ""
	cargarPuzzle
	echo "Una el punto A con el punto B"
	jugar

}

jugar ()
{
	echo "A(${puzzle[*]})B"	
	echo "El nivel actual es: $nivelActual"
	echo "Que pieza desea elegir?"
	read p
	echo "Cuantas veces la va a girar?"
	read g
	girar $p $g
}

girar ()
{
    piezaElegida=$1
    cuantoGira=$2

    if [[ -z $piezaElegida || -z $cuantoGira ]]; then
        clear
        echo "No puede dejar ningun campo vacio."
        jugar
    else
        if [[ $piezaElegida =~ ^[1-4]$ && $cuantoGira =~ ^[1-4]$ ]]; then
            indiceEnPuzzle=$(($piezaElegida - 1))
            datoPieza=${puzzle[$indiceEnPuzzle]}
            indiceEnPieza=0
			
            for ((i=0; i<${#pieza[@]}; i++)); do
                if [[ ${pieza[$i]} == "$datoPieza" ]]; then indiceEnPieza=$i; break; fi
            done
			
            # Girar la pieza
			#ENTENDER EL GIRAR PIEZA
            for ((i=0; i<cuantoGira; i++)); do
                indiceEnPieza=$(( (indiceEnPieza + 1) % ${#pieza[@]} ))
            done
            
            verificarPosicion $indiceEnPieza $indiceEnPuzzle
            
        else
            clear
            echo "Debe respetar los rangos de piezas y giros."
            jugar
        fi
    fi
}

verificarPosicion ()
{
    indiceEnPieza=$1
    indiceEnPuzzle=$2
    
    if [[ $indiceEnPuzzle -eq 0 && $nivelActual -eq 1 ]]; then
        puzzle[$indiceEnPuzzle]=${pieza[$indiceEnPieza]}
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 1; else jugar; fi
    elif [[ $indiceEnPuzzle -eq 1 && $nivelActual -eq 2 ]]; then
		puzzle[$indiceEnPuzzle]=${pieza[$indiceEnPieza]}
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 2; else jugar; fi
    elif [[ $indiceEnPuzzle -eq 2 && $nivelActual -eq 3 ]]; then
		puzzle[$indiceEnPuzzle]=${pieza[$indiceEnPieza]}
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 3; else jugar; fi
    elif [[ $indiceEnPuzzle -eq 3 && $nivelActual -eq 4 ]]; then
		puzzle[$indiceEnPuzzle]=${pieza[$indiceEnPieza]}
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 4; else jugar; fi
    else
        echo "Solo puede girar la pieza que corresponda al nivel actual."
        jugar
    fi        
}


ejecutarPrueba ()
{
	case $1 in
		1)
			echo "Al parcer logro posicionar la primer pieza de forma correcta."
			echo "Pero..."
			echo "Nada es tan facil, veremos que tan rapido sos en abrir 3 programas en menos de 10 segundos." 
			prueba1 "Estos son..."
			echo "Woooow mas despacio velocista, te sobro tiempo y todo."
			echo "Sigamos con el puzzle."
			nivelActual=2
			jugar
			;;
		2)
			echo "Bueno bueno, puedo ver que alguien logro resolver la segunda parte...."
			echo "Dejame ver bien en que momento del dia nos encontramos ya que la siguiente prueba depende de esto."
			hora=$(date | awk '{print $4}' | cut -d: -f1)
			echo $hora
			if [[ $hora -lt 12 ]]; then
				echo "Mañana"
				yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=BN1WwnEDWAM" > /dev/null
				
			elif [[ $hora -ge 12 && $hora -le 18 ]]; then
				echo "Tarde"
				yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=tqQGWhge5yo" > /dev/null
				archMp3=$(ls |  grep -E mp3$)
				echo $archMp3
				rs=$(mpg321 -q "$archMp3" &)
				echo $rs
			else
				echo "Noche"
				yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=einn_UJgGGM" > /dev/null
				
			fi
			;;
		3)
			prueba3
			echo "Entiendo que resolviste el nivel 3 y te crees muy astut@ pero...."
			echo "Creo que tenemos un intruso, un HACKER"
			echo "Al parecer el sujeto esta intentando verificar nuestra conectividad a la red mediante el comando ping"
			pid=$(ps -ef | grep Hacker | grep -v grep | awk '{print $2}')
			echo "Segun lo que pude ver este es el PID del proceso: $pid"
			echo "Necesito que me indiques el comando para poder matar el proceso que esta llevando a cabo el hacker."

			flag=1
			
			while ([ $flag -eq 1 ]) 
			do
				read comando
				#revisar la comparacion
				if [[ $comando =~ ^kill[[:space:]]+$pid$ ]]; then
					kill $pid
					sigueVivo=$(ps -ef | grep Hacker | grep -v grep) 
					if [[ -z $sigueVivo ]]; then 
						echo "Al parecer lograste eliminar el intento del hacker de verificar nuestra conectividad."
						echo "Pero ahora es necesario eliminar al usuario por completo."
						echo "Tomate un descanso, ya hiciste mucho, dejame eliminar al usuario Hacker."
						deluser Hacker > /dev/null
						echo "Eliminando..."
						sleep 1
						flag=0
					else
						echo "El proceso no fue eliminado, intentalo nuevamente."
					fi
				else
					echo "No se si no tienes claro cómo matar el proceso o solo fue un error de tipeo, intenta de nuevo."
				fi
			done
			nivelActual=4
			jugar
			;;
		4)
			echo "Ya estas en la prueba final, The Final Boss, El jefe supremo, La ultima recta, El escalon mas alto."
			echo "Bueno creo que se entendio..."
			dirAct=$(pwd)
			echo "En esta prueba tendras que darme inforacion sobre un archivo oculto que dejo el hacker en el directorio actual: "$dirAct""
			echo "Una vez que lo encuentres necesito saber cuantas lineas tiene el archivo."
			echo "Finalmente deberas indicarme el tipo de archivo que es."
			echo "Te recomiendo abrir una nueva terminal para que hagas lo que necesites hacer."
			echo "Cuando vuelvas me tenes que responder la cantidad de lineas que tiene y el tipo de archivo."
			echo "Cantidad de lineas:"
			read cl
			echo "Tipo de archivo:"
			read ta

			;;
		*)
			echo "Prueba inexistente."
			sleep 1
			clear
			banner 
			controlesManual $nombreJugador
			jugar
			;;
	esac
}

Run ()
{
	if [[ $(id -u) -ne 0 ]]; then
		echo "Por favor, ejecuta este script con sudo."
	else
		clear
		banner
		menu
	fi
}

Run
 