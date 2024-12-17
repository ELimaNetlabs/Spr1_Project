#!/bin/bash
source ./Functions.sh
source ./Pruebas.sh

nombreJugador="No hay nadie jugando"
nivelActual=1;
pieza=('\' '|' '/' '-')
puzzle=()

cargarPuzzle ()
{
	for ((i = 0; i<4; i++ )); do
        	n=$((RANDOM % 3))
        	puzzle+=("${pieza[$n]}")
	done
}

esconderArchivo()
{
	mkdir ".rutaOculta"
	cd ".rutaOculta"
	echo -e '#!/bin/bash\n\necho "Lo encontraste!"' > .elOculto.sh
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
	esconderArchivo
	cargarPuzzle
	echo "Una el punto A con el punto B"
	echo "A(${puzzle[*]})B"	
	jugar

}

jugar ()
{
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
        if [[ $piezaElegida =~ ^[1-5]$ && $cuantoGira =~ ^[1-4]$ ]]; then
            echo "La pieza elegida existe"
            
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
        # Girar la pieza
        puzzle[$indiceEnPuzzle]=${pieza[$indiceEnPieza]}
        echo "A(${puzzle[*]})B"    
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 1; else jugar; fi
    elif [[ $indiceEnPuzzle -eq 1 && $nivelActual -eq 2 ]]; then
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 2; fi
    elif [[ $indiceEnPuzzle -eq 2 && $nivelActual -eq 3 ]]; then
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 3; fi
    elif [[ $indiceEnPuzzle -eq 3 && $nivelActual -eq 4 ]]; then
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 4; fi
    elif [[ $indiceEnPuzzle -eq 4 && $nivelActual -eq 5 ]]; then
        if [[ $indiceEnPieza -eq 3 ]]; then ejecutarPrueba 5; fi
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
			echo "Nada es tan facil, veremos que tan rapido eres en abrir 3 programas en menos de 10 segundos."
			echo "Estos son..."
			echo "vim, calculadora y el editor de texto."
			for ((i = 1; i<11; i++ )); do
				echo "$i"
				sleep 1
			done
			prueba1
			;;
		2)
			echo "P2"
			;;
		3)
			prueba3
			echo "Entiendo que resolviste el nivel 3 y te crees muy astut@ pero...."
			echo "Creo que tenemos un intruso, un HACKER"
			echo "Al parecer el sujeto esta intentando verificar nuestra conectividad a la red mediante el comando ping"
			pid=$(ps -ef | grep Hacker | grep -v grep | awk '{print $2}')
			echo "Segun lo que pude ver este es el PID del proceso: "
			echo "Necesito que me indiques el comando para poder matar el proceso que esta llevando a cabo el hacker"
			
			read comando

			;;
		4)
			echo "P4"
			;;
		5)
			echo "P5"
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
 