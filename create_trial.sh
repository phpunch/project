
echo "### CREATE TRIALS FILE ###"
echo "### at ./exp/trials    ###"

if [ -f ./exp/trials ]; then
    # if trials exists already, back it up
    mkdir ./exp/.backup
    cp ./exp/trials ./exp/.backup/trials
    rm ./exp/trials
fi

test_dir=$1
spk_ivecs=${test_dir}/spk_xvector.scp #./exp/xvector_nnet_1a/xvectors_test-clean/spk_xvector.scp
utt_ivecs=${test_dir}/xvector.scp #./exp/xvector_nnet_1a/xvectors_test-clean/xvector.scp

trials=./exp/trials

while read utt; do
    utt=( $utt );
    utt=${utt[0]}
    uttspk=(${utt//-/ })
    uttspk=${uttspk[0]}-${uttspk[1]}
    while read spk; do
        spk=( $spk );
        spk=${spk[0]};
        #echo $spk $uttspk
        if [ "$spk" == "$uttspk" ]; then 
            echo $spk $utt "target" >> $trials;
        else
            echo $spk $utt "nontarget" >> $trials;
        fi
    done <$spk_ivecs;
done <$utt_ivecs
