#!/usr/bin/env bash
#             __ _       _     _            _              _   _
#  _ __ ___  / _(_)     | |__ | |_   _  ___| |_ ___   ___ | |_| |__
# | '__/ _ \| |_| |_____| '_ \| | | | |/ _ \ __/ _ \ / _ \| __| '_ \
# | | | (_) |  _| |_____| |_) | | |_| |  __/ || (_) | (_) | |_| | | |
# |_|  \___/|_| |_|     |_.__/|_|\__,_|\___|\__\___/ \___/ \__|_| |_|
#
# Rofi Audio Output Selector for PipeWire
# Inspired by rofi-bluetooth
#
# Depends on: rofi, pipewire-pulse (pactl)

# Constants
divider="---------"
goback="Back"

# Get current default sink
get_current_sink() {
    pactl get-default-sink
}

# Get all available sinks with their descriptions
get_sinks() {
    pactl list short sinks | while read -r line; do
        sink_id=$(echo "$line" | cut -f1)
        sink_name=$(echo "$line" | cut -f2)
        # Get human-readable description
        description=$(pactl list sinks | grep -A 20 "Name: $sink_name" | grep "Description:" | cut -d' ' -f2- | head -1)
        echo "$sink_name|$description"
    done
}

# Check if sink is the current default
is_current_sink() {
    current=$(get_current_sink)
    if [[ "$1" == "$current" ]]; then
        return 0
    else
        return 1
    fi
}

# Set default sink
set_default_sink() {
    pactl set-default-sink "$1"
    # Move all current streams to new sink
    pactl list short sink-inputs | while read -r stream; do
        stream_id=$(echo "$stream" | cut -f1)
        pactl move-sink-input "$stream_id" "$1" 2>/dev/null
    done
    show_menu
}

# Get volume of a sink
get_sink_volume() {
    pactl list sinks | grep -A 15 "Name: $1" | grep "Volume:" | head -1 | grep -oP '\d+%' | head -1
}

# Set volume of current sink
set_volume() {
    current_sink=$(get_current_sink)
    case "$1" in
        "up")
            pactl set-sink-volume "$current_sink" +5%
            ;;
        "down")
            pactl set-sink-volume "$current_sink" -5%
            ;;
        "mute")
            pactl set-sink-mute "$current_sink" toggle
            ;;
    esac
    show_menu
}

# Print current audio status for status bars
print_status() {
    current_sink=$(get_current_sink)
    if [[ -n "$current_sink" ]]; then
        description=$(pactl list sinks | grep -A 20 "Name: $current_sink" | grep "Description:" | cut -d' ' -f2- | head -1)
        volume=$(get_sink_volume "$current_sink")
        
        # Check if muted
        if pactl list sinks | grep -A 15 "Name: $current_sink" | grep -q "Mute: yes"; then
            echo "🔇 $description ($volume)"
        else
            echo "🔊 $description ($volume)"
        fi
    else
        echo "No audio device"
    fi
}

# Audio device submenu
device_menu() {
    sink_info="$1"
    sink_name=$(echo "$sink_info" | cut -d'|' -f1)
    sink_desc=$(echo "$sink_info" | cut -d'|' -f2)
    
    # Build options
    if is_current_sink "$sink_name"; then
        status="Status: Active (Default)"
    else
        status="Status: Available"
    fi
    
    volume=$(get_sink_volume "$sink_name")
    volume_info="Volume: $volume"
    
    options="$status\n$volume_info\nSet as Default\nVolume Up (+5%)\nVolume Down (-5%)\nToggle Mute\n$divider\n$goback\nExit"
    
    # Open rofi menu
    chosen="$(echo -e "$options" | $rofi_command "$sink_desc")"
    
    case "$chosen" in
        "" | "$divider")
            echo "No option chosen."
            ;;
        "Set as Default")
            set_default_sink "$sink_name"
            ;;
        "Volume Up (+5%)")
            pactl set-sink-volume "$sink_name" +5%
            device_menu "$sink_info"
            ;;
        "Volume Down (-5%)")
            pactl set-sink-volume "$sink_name" -5%
            device_menu "$sink_info"
            ;;
        "Toggle Mute")
            pactl set-sink-mute "$sink_name" toggle
            device_menu "$sink_info"
            ;;
        "$goback")
            show_menu
            ;;
    esac
}

# Main menu
show_menu() {
    # Get current sink info
    current_sink=$(get_current_sink)
    current_desc=""
    if [[ -n "$current_sink" ]]; then
        current_desc=$(pactl list sinks | grep -A 20 "Name: $current_sink" | grep "Description:" | cut -d' ' -f2- | head -1)
    fi
    
    # Build device list
    devices=""
    while IFS= read -r sink_info; do
        sink_name=$(echo "$sink_info" | cut -d'|' -f1)
        sink_desc=$(echo "$sink_info" | cut -d'|' -f2)
        
        if is_current_sink "$sink_name"; then
            devices="$devices● $sink_desc (Active)\n"
        else
            devices="$devices○ $sink_desc\n"
        fi
    done < <(get_sinks)
    
    # Volume controls for current device
    volume_controls="Volume Up (+5%)\nVolume Down (-5%)\nToggle Mute"
    
    # Build full options
    options="$devices$divider\n$volume_controls\n$divider\nRefresh\nExit"
    
    # Instructions for user
    instructions="Alt+Enter: Set as Default | Enter: Device Menu"
    
    # Volume controls for current device
    volume_controls="Volume Up (+5%)\nVolume Down (-5%)\nToggle Mute"
    
    # Build full options
    options="$instructions\n$divider\n$devices$divider\n$volume_controls\n$divider\nRefresh\nExit"
    
    # Open rofi menu and capture both output and exit code
    chosen="$(echo -e "$options" | $rofi_command -p "Audio Output")"
    exit_code=$?
    
    # Handle different exit codes
    case "$exit_code" in
        10) # Alt+Return pressed (kb-custom-1)
            if [[ "$chosen" =~ ^[●○]\ (.+)$ ]]; then
                device_desc="${BASH_REMATCH[1]}"
                device_desc="${device_desc% (Active)}"  # Remove (Active) suffix
                
                # Find and set as default directly
                while IFS= read -r sink_info; do
                    sink_desc=$(echo "$sink_info" | cut -d'|' -f2)
                    if [[ "$sink_desc" == "$device_desc" ]]; then
                        sink_name=$(echo "$sink_info" | cut -d'|' -f1)
                        pactl set-default-sink "$sink_name"
                        
                        # Move all current streams to new sink
                        pactl list short sink-inputs | while read -r stream; do
                            stream_id=$(echo "$stream" | cut -f1)
                            pactl move-sink-input "$stream_id" "$sink_name" 2>/dev/null
                        done
                        
                        # Show notification (optional)
                        notify-send "Audio Output" "Switched to: $sink_desc" 2>/dev/null || true
                        
                        # Return to menu
                        show_menu
                        return
                    fi
                done < <(get_sinks)
            fi
            ;;
        11) # Ctrl+Return pressed (kb-custom-2)
            # Você pode adicionar outra ação aqui, como abrir configurações de áudio
            if [[ "$chosen" =~ ^[●○]\ (.+)$ ]]; then
                device_desc="${BASH_REMATCH[1]}"
                device_desc="${device_desc% (Active)}"
                
                # Exemplo: abrir menu de dispositivo diretamente
                while IFS= read -r sink_info; do
                    sink_desc=$(echo "$sink_info" | cut -d'|' -f2)
                    if [[ "$sink_desc" == "$device_desc" ]]; then
                        device_menu "$sink_info"
                        return
                    fi
                done < <(get_sinks)
            fi
            ;;
        1) # ESC pressed or cancelled
            exit 0
            ;;
        0) # Normal Enter pressed
            case "$chosen" in
                "" | "$divider" | "$instructions")
                    echo "No option chosen."
                    ;;
                "Volume Up (+5%)")
                    set_volume "up"
                    ;;
                "Volume Down (-5%)")
                    set_volume "down"
                    ;;
                "Toggle Mute")
                    set_volume "mute"
                    ;;
                "Refresh")
                    show_menu
                    ;;
                "Exit")
                    exit 0
                    ;;
                *)
                    # Check if a device was selected
                    if [[ "$chosen" =~ ^[●○]\ (.+)$ ]]; then
                        device_desc="${BASH_REMATCH[1]}"
                        device_desc="${device_desc% (Active)}"  # Remove (Active) suffix
                        
                        # Find the corresponding sink and open device menu
                        while IFS= read -r sink_info; do
                            sink_desc=$(echo "$sink_info" | cut -d'|' -f2)
                            if [[ "$sink_desc" == "$device_desc" ]]; then
                                device_menu "$sink_info"
                                break
                            fi
                        done < <(get_sinks)
                    fi
                    ;;
            esac
            ;;
        *)
            # Unexpected exit code
            echo "Unexpected exit code: $exit_code"
            ;;
    esac

}

# Rofi command
rofi_command="rofi -dmenu $* -p -kb-custom-1 Alt+Return -kb-custom-2 Alt+Shift+Return -config ~/.config/rofi/audio.rasi"

# Handle command line arguments
case "$1" in
    --status)
        print_status
        ;;
    --volume-up)
        pactl set-sink-volume "$(get_current_sink)" +5%
        ;;
    --volume-down)
        pactl set-sink-volume "$(get_current_sink)" -5%
        ;;
    --mute)
        pactl set-sink-mute "$(get_current_sink)" toggle
        ;;
    *)
        show_menu
        ;;
esac
