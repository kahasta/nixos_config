{ pkgs, ... }:
{
  xdg.configFile."i3blocks.conf" = {
    target = "i3/i3blocks.conf";
    text = ''
      # i3blocks config file
      #
      # Please see man i3blocks for a complete reference!
      # The man page is also hosted at http://vivien.github.io/i3blocks
      #
      # List of valid properties:
      #
      # align
      # color
      # background
      # border
      # command
      # full_text
      # instance
      # interval
      # label
      # min_width
      # name
      # separator
      # separator_block_width
      # short_text
      # signal
      # urgent

      # Global properties
      #
      # The top properties below are applied to every block, but can be overridden.
      # Each block command defaults to the script name to avoid boilerplate.
      # command=/usr/lib/i3blocks/$BLOCK_NAME
      command=${pkgs.i3blocks-gaps}/libexec/i3blocks/$BLOCK_NAME
      #command=~/.config/i3/i3blocks/$BLOCK_NAME
      separator_block_width=15
      markup=none

      # [i3-focusedwindow]
      # label=[]= 
      # command=~/i3-focus 20
      # interval=persist

      [title]
      label=
      command=xdotool getactivewindow getwindowname 2>/dev/null || echo "None"
      interval=1

      [process]
      label=
      #command=ps -eo pcpu,comm | sort -k 1 -nr | head -1
      command=ps -Ao pcpu,comm --sort=-pcpu --no-headers | head -n 1
      interval=2

      [CPU]
      label=CPU_T 
      command=sensors | grep "Core 0" | awk '{print $3}'
      color=#00C853
      interval=10

      [GPU]
      label=GPU_T 
      command=~/video_temp.sh
      color=#00BFA5
      interval=3

      # CPU usage
      #
      # The script may be called with -w and -c switches to specify thresholds,
      # see the script for details.
      #[cpu_usage]
      #label=CPU
      #interval=10
      #min_width=CPU: 100.00%
      #separator=false

      #[load_average]
      #interval=10

      [Kernel]
      label=KERNEL
      command=uname -r
      color=#3d7c4d
      interval=once

      # Memory usage
      #
      # The type defaults to "mem" if the instance is not specified.
      [memory]
      label=MEM
      color=#F9A825
      # separator=false
      interval=30

      #[memory]
      #label=SWAP
      #instance=swap
      #separator=false
      #interval=30

      # Disk usage
      #
      # The directory defaults to $HOME if the instance is not specified.
      # The script may be called with a optional argument to set the alert
      # (defaults to 10 for 10%).

      [disk]
      label=/ 
      color=#AEEA00
      instance=/
      interval=30

      [disk]
      label=/home 
      color=#AEEA00
      instance=/home
      interval=30

      # Network interface monitoring
      #
      # If the instance is not specified, use the interface used for default route.
      # The address can be forced to IPv4 or IPv6 with -4 or -6 switches.
      #[iface]
      #instance=enp2s0
      #color=#00FF00
      #interval=10
      #separator=false

      # [wifi]
      # instance=wlo1
      # interval=10
      # separator=false
      #
      #[bandwidth]
      #label=NET
      #instance=enp2s0
      # interval=5


      # Battery indicator
      #
      # The battery instance defaults to 0.
      #[battery]
      #label=BAT
      #label=⚡
      #instance=1
      #interval=30

      # Volume indicator
      #
      # The first parameter sets the step (and units to display)
      # The second parameter overrides the mixer selection
      # See the script for details.
      [volume]
      #label=VOL
      label=
      instance=Master
      #instance=PCM
      interval=once
      signal=10

      # Date Time
      #
      [time]
      label=
      command=date '+%Y-%m-%d %H:%M:%S'
      interval=5

    '';
  };
}
