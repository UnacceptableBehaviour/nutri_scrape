# Automake TOC for repo & add Latex maths to Readme.md
REPO: [create_TOC_for_mark_down](https://gist.github.com/UnacceptableBehaviour/ad168b1b86a7695e9391ff063550c340)  
See [References](#refs---12-activation-functions) for example linking to contents  


## Abstract
This Readme.md is 50% example of the kind of readme that can but pushed to repo in one command (including rendering embedded latex), and 50% [instruction](#how-to-use-this-tool) on how to install and use it. Initially I was using Texify to add the maths equations, but one day it stopped working and all my maths content went up in smoke so I created this as a temporary solution. It requires the installation of [Latex](https://www.latex-project.org/get/) and [readme2tex](https://pypi.org/project/readme2tex/) to render the SVG files which form the maths content.

## Progress
KEY: (:white_check_mark:) watched, (:mag:) rewatch, (:flashlight:) unseen / to watch, (:question:) problem / open question  
CODE: (:seedling:) code complete, (:cactus:) incomplete / needs work, (:lemon:) not happy / code smells,  

Add table later if relevant.  


## Contents  
1. [Abstract](#abstract)  
2. [Progress](#progress)  
3. [Contents](#contents)  
4. [AIM: maintain a Readme.md doc with a table of contents and Latex equations!](#aim-maintain-a-readmemd-doc-with-a-table-of-contents-and-latex-equations)  
5. [How to use this tool.](#how-to-use-this-tool)  
	1. [Installing in repo](#installing-in-repo)  
	2. [Readme source RTF file](#readme-source-rtf-file)  
	3. [Comments](#comments)  
	4. [The TOC](#the-toc)  
	5. [Adding maths equations to Readme.md](#adding-maths-equations-to-readmemd)  
	6. [Updating the Readme.md file](#updating-the-readmemd-file)  
6. [Some examples of Readme.md content](#some-examples-of-readmemd-content)  
	1. [11 - Softmax and Cross Entropy](#11---softmax-and-cross-entropy)  
		1. [**Vid contents - 11 softmax & X-entropy**](#vid-contents---11-softmax--x-entropy)  
		2. [Sigmoid function](#sigmoid-function)  
		3. [Softmax equation:](#softmax-equation)  
		4. [Refs 11 - softmax & cross entropy](#refs-11---softmax--cross-entropy)  
		5. [Cross-Entropy equation:](#cross-entropy-equation)  
	2. [12 - Activation Functions](#12---activation-functions)  
		1. [**Vid contents - 11 softmax & X-entropy**](#vid-contents---11-softmax--x-entropy)  
		2. [Neural Network code example](#neural-network-code-example)  
		3. [Refs - 12 activation functions](#refs---12-activation-functions)  


## AIM:  

To be able to maintain a Readme.md doc with a table of contents and Latex equations!   


## How to use this tool.  
### Installing in repo  
Download the install file:  
```
cd /lang/ruby/repos/nutri_scrape                      # cd into relevant repo root directory
                                                      # download install file
curl -L https://github.com/UnacceptableBehaviour/create_TOC_for_md/raw/main/install_createTOC.sh > install_createTOC.sh
chmod +x install_createTOC.sh                         # make it executable
./install_createTOC.sh                                # run it
```
This will install 
  
### Readme source RTF file
  
### Comments
The source file can contain comments that will be removed from the copy that is put in the Readme.md file:  
/ / *  
inside C esque comments will be removed by the create_TOC_for_md.py script.  
As shown at the start and end of this section.  
Allows tidy up of what is pushed to git - useful for work in progress or notes  
* / /  
  
### The TOC
  
### Adding maths equations to Readme.md
  
### Updating the Readme.md file
Simple running 
  

## Some examples of Readme.md content  
### 11 - Softmax and Cross Entropy  
([vid](https://www.youtube.com/watch?v=7q7E91pHoW4&list=PLqnslRFeH2UrcDBWF5mfPGpqQDSta6VK4&index=12)) - 
([code](https://github.com/UnacceptableBehaviour/pytorch_tut_00/blob/main/scripts/09_tensor_data_loader.py)) - 
([code python \_\_call\_\_](https://github.com/UnacceptableBehaviour/python_koans/blob/master/python3/scratch_pad_1b_instance__call__.py))  
  
#### **Vid contents - 11 softmax & X-entropy**
 time				| notes	
| - | - |
**0m**		| intro
**source**	| https://pytorch.org/vision/stable/_modules/torchvision/transforms/transforms.html
**0m**		| intro softmax maths
**0m30**	| softmax formula
**1m20**	| softmax diagram : scores, logits, probabilities (sum of probabilities = 1), prediction
note		| better prediction = lower Cross-Entropy loss
**4m05**	| One-Hot encoding: Each class represented by a single binary 1 on classificaton array [0,1,0,0]
note		| nn.CrossEntropyLoss applies nn.LogSoftmax + nn NLLLoss (-ve log liklihood loss)
note		| Y has class labels not one-hot
**16m30**	| Neural Net w/ Sigmoid - slide - binary
**17m10**	| Neural Net w/ Sigmoid - code


#### Sigmoid function
![sigmoid function](https://github.com/UnacceptableBehaviour/pytorch_tut_00/blob/main/imgs/sigmoid_function.png)  
Sigmoid function (for any value of x is between 0 & 1, crossover at 0.5) [6m maths](https://www.youtube.com/watch?v=TPqr8t919YM):
<p align="center"><img src="./tex/b744bbbaeaa991fd7cb8ea9d8b96067d.svg?invert_in_darkmode" align=middle width=361.00828665pt height=34.3600389pt/></p>
Important thing to note is:
<p align="center"><img src="./tex/d5b67a1adb489ef5eba6b8b1e145bcdb.svg?invert_in_darkmode" align=middle width=179.7600156pt height=22.6484214pt/></p>
Used to map output values into probabilities (values between 0 - 1).  

#### Softmax equation:
<p align="center"><img src="./tex/3efb236387e0b3da0f331abc7caf7b0f.svg?invert_in_darkmode" align=middle width=102.61048545pt height=37.425951749999996pt/></p>
What this equation describes is element wise exponentiation divided by the sum of those exponentiations.  
  
![softmax element exponentiation](https://github.com/UnacceptableBehaviour/pytorch_tut_00/blob/main/imgs/softmax_element_exponentiation.png)   
  
The far right column represent the Sum of exponentiations for each element.   
The preceding 4 the exponentiation of each element.   
Who is divided by the sum to get the softmax probability outputs.   
[desmos - softmax bar charts](https://www.desmos.com/calculator/drqqhtb037) < interactive.   
  
What are logits? Output score from linear layer I think. .
What is an activation function?

#### Refs 11 - softmax & cross entropy
Good visual explanation of how outputs from linear block are converted to probabilities by the softmax block:
[softmax w/ 3d visuals](https://www.youtube.com/watch?v=ytbYRIN0N4g).  

Here Andrew Ng walks through the maths with an example 3m element wise exponentiation
[Andrew Ng- walks through maths example](https://www.youtube.com/watch?v=LLux1SW--oM).  
  
[Sigmoid function](https://www.youtube.com/watch?v=TPqr8t919YM).  


#### Cross-Entropy equation:
Used to home in on a better answer, the lower the cross-entropy loss the closer to target we are.
<p align="center"><img src="./tex/a796f18824561d22a6ec64fd3c494f3d.svg?invert_in_darkmode" align=middle width=356.61131055pt height=32.990165999999995pt/></p>
TODO - explain the maths
Start w/ single output example, then above is simply a summation for of each of the loss functions for multiple class outputs.  
  
---
### 12 - Activation Functions  
([vid](https://www.youtube.com/watch?v=3t9lZM7SS7k&list=PLqnslRFeH2UrcDBWF5mfPGpqQDSta6VK4&index=13)) - 
([code](https://github.com/UnacceptableBehaviour/pytorch_tut_00/blob/main/scripts/12_tensor_activation_functions.py))   
  
#### **Vid contents - 11 softmax & X-entropy**
 time				| notes	
| - | - |
**0m**		| Intro to activation functions - rationale
**2m**		| Popular activation functions
note 		| Step function, Sigmoid, TanH, ReLU, Leaky ReLU, Softmax
**2m25**	| Sigmoid 0 to 1: Last layer of binary classificatioon problem
**2m50**	| TanH -1 to +1: Scaled & shifted sigmoid function - used in hidden layers
**3m20**	| ReLU: Rectified Linear Unit: 0 for -ve inputs, linear for +ve inputs
 note		| better performance than sigmoid
**4m20**	| Leaky ReLU: Used in solving Vanishing gradient problem
**5m40**	| Softmax:Typically good choice in last layer of a multi classification problem
**6m30**	| Walk the 1st Neural Network code
**7m40**	| Walk the 2nd Neural Network code
**note**		| the NN code isn't executed - next episode
**8m30**	| API: torch.nn, torch.nn.functional


#### Neural Network code example
```
class NeuralNet(nn.Module):
    # initialise models named object vasr with standard functions
    def __init__(self, input_size, hidden_size):
        super(NeuralNet, self).__init__()
        self.linear1 = nn.Linear(input_size, hidden_size)
        self.relu = nn.ReLU()
        self.linear2 = nn.Linear(hidden_size, 1)
        self.sigmoid = nn.Sigmoid()

    # use object name in forward pass
    # output from each step/layer is passed to the next step/layer
    def forward(self, x):
        out = self.linear1(x)
        out = self.relu(out)
        out = self.linear2(out)
        out = self.sigmoid(out)
        return out
```
Is the activation function then a filter that shapes the output to the next layer? Basically yes!
Activation function decides, whether a neuron should be activated or not by calculating weighted sum and further adding bias with it. The purpose of the activation function is to introduce non-linearity into the output of a neuron.  
[Activation functions - wikiP](https://en.wikipedia.org/wiki/Activation_function).  


#### Refs - 12 activation functions
Pytorch Modules [ref here](https://pytorch.org/docs/stable/generated/torch.nn.Module.html).  
Example pipeline [digit identifier](https://pytorch.org/tutorials/beginner/blitz/neural_networks_tutorial.html).  

---



 