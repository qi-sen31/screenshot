O script **screenshot.sh** automatiza a captura de screenshots (capturas de tela).


Ele envolve o uso de ferramentas como maim, scrot, flameshot, gnome-screenshot, entre outras, para capturar a 
tela. Oferece as opções de tirar capturas de tela de uma janela específica, selecionar uma área da tela ou 
capturar a tela inteira.



Exemplos de funcionalidades que o screenshot.sh pode oferecer:

**Captura de tela inteira:**

O script pode usar ferramentas como maim ou scrot para capturar toda a tela e salvar a imagem em um diretório específico.

**Captura de uma janela específica:**

Pode capturar a tela de uma janela ativa, como em maim --window $(xdotool getactivewindow) ou import -window $(xdotool getactivewindow).

**Seleção de área:**

Pode permitir que o usuário selecione uma área da tela para captura, como em maim --select ou flameshot gui.

**Cópia para a área de transferência:**

Pode usar xclip para copiar a captura de tela para a área de transferência, por exemplo, maim | xclip -selection clipboard -t image/png.

**Notificações:**

O script pode incluir notificações para informar ao usuário que a captura foi realizada com sucesso ou falhou.



**Atribuindo a uma tecla no i3wm:** Para facilitar o uso, você pode adicionar um atalho de 
teclado no i3wm para chamar o script. No arquivo de configuração do i3 (~/.config/i3/config), 
adicione uma linha como esta:


**Screenshots**

bindsym Print       exec --no-startup-id /usr/local/bin/screenshot.sh            <br>
bindsym $mod+Print  exec --no-startup-id /usr/local/bin/screenshot.sh --select   <br>
bindsym Shift+Print exec --no-startup-id /usr/local/bin/screenshot.sh --window   <br> <br>


Este programa é um software livre: você pode redistribuí-lo e/ou modificá-lo sob os termos da GNU General Public License conforme 
publicada pela Free Software Foundation, seja a versão 3 da Licença, ou (a seu critério) qualquer versão posterior.

Este programa é distribuído na esperança de que seja útil, mas SEM NENHUMA GARANTIA; sem mesmo a garantia implícita de COMERCIALIZAÇÃO 
ou ADEQUAÇÃO A UM PROPÓSITO ESPECÍFICO. Veja a GNU General Public License para mais detalhes.
