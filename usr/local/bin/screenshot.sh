#!/bin/bash
#
# Autor:           Fernando Souza - https://www.youtube.com/@fernandosuporte/
# Data:            12/02/2025 as 18:07:24
# Atualização em:  https://github.com/tuxslack/screenshot
# Script:          screenshot.sh
# Versão:          0.1
#
#
# Automatiza a captura de tela usando ferramentas como maim, scrot, flameshot, 
# gnome-screenshot, entre outras. Oferece as opções de tirar capturas de tela de uma 
# janela específica, selecionar uma área da tela ou capturar a tela inteira.
#
#
# Data da atualização:  
#
# Licença: GPL3 - https://www.gnu.org/
# 
#
# Requer: notify-send

# Instalação:

# mv -i ~/Downloads/screenshot.sh /usr/local/bin/


# Dê permissões de execução: Torne o script executável com o comando:

# chmod +x /usr/local/bin/screenshot.sh


# Para tirar uma captura de tela:

# screenshot.sh

# Para capturar uma janela específica:

# screenshot.sh --window


# Para selecionar uma área:

# screenshot.sh --select


# Atribuindo a uma tecla no i3wm: Para facilitar o uso, você pode adicionar um atalho de 
# teclado no i3wm para chamar o script. No arquivo de configuração do i3 (~/.config/i3/config), 
# adicione uma linha como esta:


## Screenshots

# bindsym Print       exec --no-startup-id /usr/local/bin/screenshot.sh
# bindsym $mod+Print  exec --no-startup-id /usr/local/bin/screenshot.sh --select
# bindsym Shift+Print exec --no-startup-id /usr/local/bin/screenshot.sh --window


# ----------------------------------------------------------------------------------------

# Verificar se notify-send está instalado

if ! command -v notify-send &> /dev/null; then

    clear

    echo -e "\n\033[1;31mnotify-send não encontrado. As notificações não serão exibidas.\033[0m\n"

    USE_NOTIFY=false

else

    USE_NOTIFY=true

fi


# ----------------------------------------------------------------------------------------


# Defina o diretório para salvar a captura de tela

# Usando xdg-user-dir para identificar o diretório de imagens

OUTPUT_DIR="$(xdg-user-dir PICTURES)/screenshots"



# Verifique se o diretório existe

if [ ! -d "$OUTPUT_DIR" ]; then

    clear

    # Crie o diretório de screenshots, se não existir

    mkdir -p "$OUTPUT_DIR"

    echo -e "\n\033[1;31mDiretório de imagens não encontrado. Criando $OUTPUT_DIR\033[0m\n"

else

    clear

    echo -e "\n\033[1;32mDiretório de imagens encontrado: $OUTPUT_DIR \033[0m\n"

fi

# ----------------------------------------------------------------------------------------


# Defina o nome do arquivo com base na data e hora

FILENAME="screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

# ----------------------------------------------------------------------------------------

# Caminho completo para o arquivo

OUTPUT_FILE="$OUTPUT_DIR/$FILENAME"


# Função para capturar a tela e salvar na área de transferência

screenshot_clipboard() {

    maim | xclip -selection clipboard -t image/png

    if [ "$USE_NOTIFY" = true ]; then

        notify-send "Screenshot" "Screenshot salva na área de transferência com maim."

    else

        echo "Screenshot salva na área de transferência com maim."

    fi
}

# ----------------------------------------------------------------------------------------

# Verificar se 'maim' está instalado

if command -v maim &> /dev/null; then

    if [ "$1" == "--select" ]; then

        # Captura uma área selecionada

        maim --select | xclip -selection clipboard -t image/png

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot selecionada e copiada para a área de transferência com maim."

        else

            echo "Screenshot selecionada e copiada para a área de transferência com maim."

        fi


    elif [ "$1" == "--window" ]; then

        # Captura a janela ativa

        maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot da janela ativa copiada para a área de transferência com maim."

        else

            echo "Screenshot da janela ativa copiada para a área de transferência com maim."

        fi


    else

        # Captura a tela inteira

        maim | xclip -selection clipboard -t image/png

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot salva na área de transferência com maim."

        else

            echo "Screenshot salva na área de transferência com maim."

        fi

    fi

# ----------------------------------------------------------------------------------------


# Verificar se 'scrot' está instalado

elif command -v scrot &> /dev/null; then

    if [ "$1" == "--window" ]; then

        # Captura a janela ativa

        scrot -u "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot da janela ativa salva com scrot em $OUTPUT_FILE"

        else

            echo "Screenshot da janela ativa salva com scrot em $OUTPUT_FILE"

        fi


    elif [ "$1" == "--select" ]; then

        # Captura uma área selecionada

        scrot -s "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot selecionada salva com scrot em $OUTPUT_FILE"

        else

            echo "Screenshot selecionada salva com scrot em $OUTPUT_FILE"

        fi

    else

        # Captura a tela inteira

        scrot "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot salva com scrot em $OUTPUT_FILE"

        else

            echo "Screenshot salva com scrot em $OUTPUT_FILE"

        fi
    fi

# ----------------------------------------------------------------------------------------

# Verificar se 'flameshot' está instalado

elif command -v flameshot &> /dev/null; then

    if [ "$1" == "--select" ]; then

        # Captura uma área selecionada

        flameshot gui -p "$OUTPUT_DIR"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot selecionada salva com flameshot em $OUTPUT_FILE"

        else

            echo "Screenshot selecionada salva com flameshot em $OUTPUT_FILE"

        fi

    else

        # Captura a tela inteira

        flameshot full -p "$OUTPUT_DIR"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot salva com flameshot em $OUTPUT_FILE"

        else

            echo "Screenshot salva com flameshot em $OUTPUT_FILE"

        fi
    fi

# ----------------------------------------------------------------------------------------

# Verificar se 'gnome-screenshot' está instalado

elif command -v gnome-screenshot &> /dev/null; then

    if [ "$1" == "--window" ]; then

        # Captura a janela ativa

        gnome-screenshot -w -f "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot da janela ativa salva com gnome-screenshot em $OUTPUT_FILE"

        else

            echo "Screenshot da janela ativa salva com gnome-screenshot em $OUTPUT_FILE"

        fi

    elif [ "$1" == "--select" ]; then

        # Captura uma área selecionada

        gnome-screenshot -a -f "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then
            notify-send "Screenshot" "Screenshot selecionada salva com gnome-screenshot em $OUTPUT_FILE"
        else
            echo "Screenshot selecionada salva com gnome-screenshot em $OUTPUT_FILE"
        fi

    else

        # Captura a tela inteira

        gnome-screenshot -f "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot salva com gnome-screenshot em $OUTPUT_FILE"

        else

            echo "Screenshot salva com gnome-screenshot em $OUTPUT_FILE"

        fi
    fi

# ----------------------------------------------------------------------------------------

# Verificar se 'import' (ImageMagick) está instalado

elif command -v import &> /dev/null; then

    if [ "$1" == "--window" ]; then

        # Captura a janela ativa

        import -window $(xdotool getactivewindow) "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot da janela ativa salva com import em $OUTPUT_FILE"

        else

            echo "Screenshot da janela ativa salva com import em $OUTPUT_FILE"

        fi

    elif [ "$1" == "--select" ]; then

        # Captura uma área selecionada

        import "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot selecionada salva com import em $OUTPUT_FILE"

        else

            echo "Screenshot selecionada salva com import em $OUTPUT_FILE"

        fi

    else

        # Captura a tela inteira

        import -window root "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot salva com import em $OUTPUT_FILE"

        else

            echo "Screenshot salva com import em $OUTPUT_FILE"

        fi
    fi


# ----------------------------------------------------------------------------------------

# Verificar se 'xfce4-screenshooter' está instalado

elif command -v xfce4-screenshooter &> /dev/null; then

    if [ "$1" == "--select" ]; then

        # Captura uma área selecionada

        xfce4-screenshooter -s "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot selecionada salva com xfce4-screenshooter em $OUTPUT_FILE"

        else

            echo "Screenshot selecionada salva com xfce4-screenshooter em $OUTPUT_FILE"

        fi

    else

        # Captura a tela inteira

        xfce4-screenshooter -f -s "$OUTPUT_FILE"

        if [ "$USE_NOTIFY" = true ]; then

            notify-send "Screenshot" "Screenshot salva com xfce4-screenshooter em $OUTPUT_FILE"

        else

            echo "Screenshot salva com xfce4-screenshooter em $OUTPUT_FILE"

        fi
    fi

else

    if [ "$USE_NOTIFY" = true ]; then

        notify-send "Erro" "Nenhum programa de captura de tela encontrado. Instale maim, scrot, flameshot, gnome-screenshot, import ou xfce4-screenshooter."

    else

        echo "Nenhum programa de captura de tela encontrado. Instale maim, scrot, flameshot, gnome-screenshot, import ou xfce4-screenshooter."

    fi

    exit 1
fi

# ----------------------------------------------------------------------------------------


exit 0

