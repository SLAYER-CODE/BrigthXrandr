#!/bin/sh

#ITEMS

BRIGHTNESS="1:1:0.5"
BRIGHTNESS_NOT="1.0:1.0:1.0"

#Comprobando si el dispositivo esta conectado

VAR_DISPLAY=`xrandr --verbose | grep  " connected"| sed 's/ connected.*//g'`
VAR_BRIGHTNESS=`xrandr --verbose | grep  "Brightness"| sed 's/.*Brightness: //g'`
VAR_GAMA=$(xrandr --verbose | grep  "Gamma"| sed 's/.*Brightness: //g' | xargs | cut -d " " -f2)

night_mode() {
  
  for disp in $VAR_DISPLAY ; do
   	xrandr --output $disp --gamma $1 --brightness $2 
  done 
} 

nigthtoogle() {
	
	#echo $VAL
	case $VAR_GAMA in 
	$BRIGHTNESS_NOT) 
		night_mode $BRIGHTNESS $VAR_BRIGHTNESS;;
	*) 
		night_mode $BRIGHTNESS_NOT $VAR_BRIGHTNESS;;
	esac
}


if [ -z $VAR_DISPLAY ]

then

        echo "Err:Display details could not be found using xrandr"
        exit 1
fi

echo $VAR_DISPLAY


#Obteniendo el brillo de las configuraciones entre 0 y uno [0 - 1]


if [ -z $VAR_BRIGHTNESS ]

then

        echo "Err:Brightness setting could not be found using xrandr"
        exit 1
fi

#incrementado el brillo o decrementandolo

if [ -z $1 ]

then

        echo "Especifica esta opcion --increment | --decrement | --togleNighth"

else if [ $1 = "--increment" ]

then
       	
	#LET_BRIGHTNESS=$BRIGHTNESS
	case $VAR_GAMA in
	$BRIGHTNESS_NOT)
		#LET_BRIGHTNESS=$BRIGHTNESS_NOT ;;
		BRIGHTNESS=$BRIGHTNESS_NOT ;;
	esac

	#echo $BRIGHTNESS
	#echo $VAR_BRIGHTNESS
	xrandr --output $VAR_DISPLAY --gamma $BRIGHTNESS --brightness `expr "$VAR_BRIGHTNESS + 0.05"|bc`

else if [ $1 = "--decrement" ]

then
	case $VAR_GAMA in 
        $BRIGHTNESS_NOT) 
       		BRIGHTNESS=$BRIGHTNESS_NOT ;; 
	esac

	#echo $BRIGHTNESS
	#echo $VAR_BRIGHTNESS
	test $( expr `expr "$VAR_BRIGHTNESS - .06"|bc`" < 0.3"|bc ) -eq 1 || xrandr --output $VAR_DISPLAY --gamma $BRIGHTNESS --brightness `expr "$VAR_BRIGHTNESS - 0.06"|bc`
else if [ $1 = "--togleNigth" ]

then
	nigthtoogle
else

        echo "Specify one of following option --increment | --decrement | --togleNigth"
fi

fi

fi

fi

autorandr --save work --force    
