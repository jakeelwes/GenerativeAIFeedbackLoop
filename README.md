# GenerativeAIFeedbackLoop
PPGN with DenseCap - Feedback Loop
Jake Elwes 2017

Using densecap:

**[DenseCap: Fully Convolutional Localization Networks for Dense Captioning](http://cs.stanford.edu/people/karpathy/densecap/)**,
<br>
[Justin Johnson](http://cs.stanford.edu/people/jcjohns/)\*,
[Andrej Karpathy](http://cs.stanford.edu/people/karpathy/)\*,
[Li Fei-Fei](http://vision.stanford.edu/feifeili/),
<br>
(\* equal contribution)
<br>
Presented at [CVPR 2016](http://cvpr2016.thecvf.com/) (oral)

and PPGN:
**[Plug & Play Generative Networks: Conditional Iterative Generation of Images in Latent Space](http://www.evolvingai.org/ppgn)**,
<br>
[Nguyen A](http://anhnguyen.me), [Yosinski J](http://yosinski.com/), [Bengio Y](http://www-labs.iro.umontreal.ca/~bengioy/yoshua_en/), [Dosovitskiy A](http://lmb.informatik.uni-freiburg.de/people/dosovits/), [Clune J](http://jeffclune.com). (2016). ["Plug & Play Generative Networks: Conditional Iterative Generation of Images in Latent Space"](http://arxiv.org/abs/1612.00005v1). arXiv:1612.00005v1.

##Running it

Need GPU to run (can use AWS if have no GPU)
[This docker image](https://github.com/jakeelwes/dl-docker) (Dockerfile_caffeCaptions.gpu) has the dependencies included

Start with any image named 'currentImage/toCap.jpg'

Then run with
```
./generateLoop.sh {nuber of generations wanted}
```
