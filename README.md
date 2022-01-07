# BrigthXrandr

Para aquellos que sufren de los ojos
COnfigura el brillo desde la terminal
esta inspirado en el problema https://qastack.mx/ubuntu/162317/screen-brightness-not-working

# Istalación:

```bash
sudo mkdir /usr/share/scripts
git clone https://github.com/SLAYER-CODE/BrigthXrandr.git
cd BrigthXrandr cp brilloXrandr.bash /usr/share/scripts/brilloXrandr.bash
```

```bash
sudo apt install autorand
```

# Configuracion
Para que la configuracion se guarde pueden modificar el archivo .bspwmrc , .bashrc , .zshrc
y ponder lo siguiente:

```bash
autorandr --change
```
Archivo de configuracion en sxhkdrc:

```bash
# Brillo
super + F8
        bash /usr/share/scripts/./brilloXrandr.bash --increment
super + F7
        bash /usr/share/scripts/./brilloXrandr.bash --decrement
# Luz Noturna toogle
super + F6
        bash /usr/share/scripts/./brilloXrandr.bash --togleNigth
````

# Caracterisiticas
* Baja el brillo de 100% - 1.00 unos 0.06 [> 0.03]
* Subir el brillo unos 0.05 de 1.00 sin limites
* Modificacion de luz noturna en el mismo archivo

# Errores y problemas:
* La luz noturna es modificable pero el intercambio no lo es para que pueda ser modificable es necesario compilar la nueva vercion de xrandrx por problemas con la gama de luz: https://gitlab.freedesktop.org/xorg/app/xrandr/-/issues/33
* EL brillo se baja unos 0.6 por que si se intenta bajar 0.5 xrandr redondea el valor haciendo que este nunca baje
