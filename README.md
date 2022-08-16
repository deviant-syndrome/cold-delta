#### Summary

Multimedia project in SuperCollider.
This repository contains SuperCollider code, which when being ran through the interpreter, produces an intentionally musical audio output.

Thus, this code itself could be treated as a score for a musical composition, or rather a musical composition scored and rendered entirely with the code.

#### Artistic Intention

In Jung's theory, the anima makes up the totality of the unconscious feminine psychological qualities that a man possesses.

Encountering dramatic detours on the path of healhty development of sexuality and socialisation, an individual can get totally possesed by her or, more likely, by his own imaginary construction of her.

A possible manifestation of this could be subconcisosly building a firm boundary between oneself and everything which possess beauty and grace. When looking through this fence in hope for comfort and acceptance, but met with a smug grimace of supremacy and disgust, it is time to realise that all this is just merely a projection of your own Anima. Anima, who hates you.  

Express the author's own experiences of exposure to multi-faceted concept of human gender and inter-gender relationships, especially the gendered concept of "beauty", when it clashes with various forms of oppression.  

#### Artistic Goals

Facilitate the artistic intention by exploring the boundaries of rhythm and texture within abrasive and tightly populated sonic structures.
The basic idea behind this score (code) is to model a situation where (performers?) try play along to a drum track, which is a product of a GAN, trained on a series of extreme metal drum performances, mostly focused on repeating a short figure, where
all main characteristical pieces of a rock drumkit share equal parts of the same confined space, which gives it a general feel of relentless monotonicity.

When played at fast tempos, the definition between individual percussion hits gets smudged, especially in the higher register. Traditionally for many genres, this effect is usually further emphasied by a certain set of recording practices.

The advesitile nature of a NN trained model introduces grooves and irregularities into otherwise monolithic wall of percussion hits.

Challenging the paradigm of using programmed sequences of percussion audio samples, as a surrogate for a drum track.
A modeled sound of a stringed instrument ran through a conventional hi-gain guitar amplifier rig was chosen as an accompaning instrument, to match the bleak tone of the topic being explored.


#### Technical goals

Explore the capabilities of "machine listening" provided by SuperCollider extensions. Learn basic physical modeling of a stringed intrument.

Utilise the Require quark to elevate modularisation opportunities for SuperCollider interpreter language.

Determine the feasble functional programming patterns to define logic in abscence
of classes in the pure interpreter.


#### Automatic operation

1. Complete the setup prerequisites
2. Open `composition.scd` file in SuperCollider IDE (or other)
3. Start scsynth server
4. Execute the only code block in this file 

#### Manual operation (conduction)



The on-set detectors used are
This performance tries to play along to a very intense playback of a drum performance, irregularities.  

#### How to try this on your computer

1. Download and install SuperCollider
2. Install the official SuperCollider extension pack
3. Install third-party VST Plugin extension
4. Install STL Ignite Amp guitar amplifier simulator and a IR cabinet simualtor (1)
5. Clone this repository
6. Download the WAV playback file and put it into the project's media directory
7. Open "score.scd" document file in Supercollider  

## Structure

#### Routing

`globalRouting` variable holds a dictionary of functions for adding new sound sources and building FX chains arounds them.

In the commutation section, they are used to

##### OSC Triggers


#### Machine listening


####

#####

### Topics explored
* NN-generated rhythmic sounds
* Transient following / beat detection
* String instruments modelling
* Partial synthesis

### Prerequisites

* SuperCollider
* Require quark https://github.com/scztt/Require.quark
* SuperCollider extensions
* VSTPlugin extension https://git.iem.at/pd/vstplugin


### Acknowledgements
[https://schollz.com/blog/phasedistortion/]
[https://composerprogrammer.com/teaching/supercollider/sctutorial/11.1%20Physical%20Modelling.html]
