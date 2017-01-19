#/bin/bash
#
# Jake Elwes <me@jakeelwes.com>
# 2017
# (adapted from Anh Nguyen <anh.ng8@gmail.com>)

# Take in an unit number
if [ "$#" -ne "1" ]; then
  echo "Provide a sentence"
  exit 1
fi

opt_layer=fc6     # This is fixed to be fc6 unless we change the generator
act_layer=fc8     # fc8 because the LRCN extract fc8 features from AlexNet
sentence="${1}"   # A sentence with underscores between words e.g. a_pizza_on_a_table_at_a_restaurant
xy=0              # Spatial position for conv layers, for fc layers: xy = 0

n_iters=200       # Run for N iterations
reset_every=0     # Reset the code every N iterations (for diversity). 0 to disable resetting.
save_every=1      # Save a sample every N iterations. 0 to disable saving intermediate samples.
lr=1              # Initial learning rate
lr_end=1e-10      # Linearly decay toward this ending lr (e.g. for decaying toward 0, set lr_end = 1e-10)
threshold=0       # Filter out samples below this threshold e.g. 0.98

# -----------------------------------------------
# Multipliers in the update rule Eq.11 in the paper
# -----------------------------------------------
epsilon1=1e-3     # prior
epsilon2=1        # condition
epsilon3=1e-17    # noise
# -----------------------------------------------

init_file="None"    # Start from a random code

# Condition net
net_weights="nets/lrcn/lrcn_caffenet_iter_110000.caffemodel"
net_definition="nets/caffenet/caffenet.prototxt"
captioner_definition="nets/lrcn/lrcn_word_to_preds.deploy.prototxt"
#-----------------------

# Output dir
output_dir="web-interface/genImages/"
# mkdir -p ${output_dir}

# Directory to store samples
if [ "${save_every}" -gt "0" ]; then
    sample_dir=currentImage/img/${sentence}
    mkdir -p ${sample_dir}
fi

## Run a few times
# for seed in {0..2}; do

    python ppgn/sampling_caption.py \
        --act_layer ${act_layer} \
        --opt_layer ${opt_layer} \
        --sentence ${sentence} \
        --xy ${xy} \
        --n_iters ${n_iters} \
        --save_every ${save_every} \
        --reset_every ${reset_every} \
        --lr ${lr} \
        --lr_end ${lr_end} \
        --seed ${seed} \
        --output_dir ${output_dir} \
        --init_file ${init_file} \
        --epsilon1 ${epsilon1} \
        --epsilon2 ${epsilon2} \
        --epsilon3 ${epsilon3} \
        --threshold ${threshold} \
        --net_weights ${net_weights} \
        --net_definition ${net_definition} \
        --captioner_definition ${captioner_definition} \

    # Plot the samples
    if [ "${save_every}" -gt "0" ]; then

        f_chain=${output_dir}/${sentence}

        # f_chain=${output_dir}/${sentence}__${seed}.jpg

        # Make a montage of steps
        # montage `ls ${sample_dir}/*.jpg | head -40` -tile 10x -geometry +1+1 ${f_chain}

        # readlink -f ${f_chain}
        echo "Making a gif..."
        convert ${sample_dir}/*.jpg -delay 5 -loop 0 ${f_chain}.gif
        readlink -f ${f_chain}.gif
    fi
# done

# Combine samples into one big image
# output_file=${output_dir}/${sentence}.jpg
# montage ${output_dir}/${act_layer}_*.jpg ${output_file}

mv ${output_dir}/${act_layer}_*.jpg ${output_dir}/${sentence}.jpg
cp ${output_dir}/${sentence}.jpg currentImage/toCap.jpg

readlink -f ${output_file}
