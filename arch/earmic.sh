#! /bin/bash
blumic()
{
    if [ "$1" = "off" ]; then
        profile="a2dp_sink"a
    else
        profile="headset_head_unit"
    fi

    pacmd set-card-profile <card-name> $profile
}
