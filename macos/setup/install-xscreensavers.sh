#!/usr/bin/env bash
SCREENSAVER_DIR="${HOME}/Library/Screen Savers"
delete_screensaver() { find "${SCREENSAVER_DIR}" -maxdepth 1 -name "${1}.*" -exec rm -vr "{}" \;; }

echo "Install xscreensaver package using brew."
[ -z "$(which brew)" ] && echo "Error: install brew first." && exit 1
(brew cask install xscreensaver && echo "Installation complete" )|| exit 1
read -p "Remove unused screensavers from the ${SCREENSAVER_DIR} (y/N)? " opt
[ "${opt}" != "y" ] && echo "Skip remove unused screensaver." && exit 0
# All list: https://www.jwz.org/xscreensaver/screenshots/
delete_screensaver Abstractile
delete_screensaver Anemone
delete_screensaver Anemotaxis
delete_screensaver AntInspect
delete_screensaver AntMaze
delete_screensaver AntSpotlight
delete_screensaver Apollonian
#delete_screensaver Apple2
delete_screensaver Atlantis
delete_screensaver Attraction
delete_screensaver Atunnel
#delete_screensaver BSOD
delete_screensaver Barcode
delete_screensaver BinaryRing
delete_screensaver Blaster
delete_screensaver BlinkBox
delete_screensaver BlitSpin
delete_screensaver BlockTube
delete_screensaver Boing
delete_screensaver Bouboule
delete_screensaver BouncingCow
delete_screensaver BoxFit
delete_screensaver Boxed
delete_screensaver Braid
delete_screensaver Bubble3D
delete_screensaver Bumps
delete_screensaver CCurve
delete_screensaver CWaves
delete_screensaver Cage
delete_screensaver Carousel
#delete_screensaver Celtic
delete_screensaver Circuit
delete_screensaver Cityflow
#delete_screensaver CloudLife
delete_screensaver CompanionCube
delete_screensaver Compass
#delete_screensaver Coral
delete_screensaver Crackberg
#delete_screensaver Crepuscular Life
delete_screensaver Crumbler
delete_screensaver Crystal
delete_screensaver Cube21
delete_screensaver CubeStack
delete_screensaver CubeStorm
delete_screensaver CubeTwist
delete_screensaver Cubenetic
delete_screensaver CubicGrid
delete_screensaver Cynosure
delete_screensaver DNAlogo
#delete_screensaver DaliClock
delete_screensaver DangerBall
delete_screensaver DeepStars
delete_screensaver DecayScreen
delete_screensaver Deco
delete_screensaver Deluxe
delete_screensaver Demon
delete_screensaver Discoball
delete_screensaver Discrete
delete_screensaver Distort
#delete_screensaver Drift
delete_screensaver DymaxionMap
delete_screensaver Endgame
delete_screensaver EnergyStream
delete_screensaver Engine
delete_screensaver Epicycle
delete_screensaver Eruption
delete_screensaver Esper
delete_screensaver Euler2D
delete_screensaver Extrusion
delete_screensaver FadePlot
delete_screensaver Fiberlamp
#delete_screensaver FilmLeader
delete_screensaver Fireworkx
delete_screensaver Flame
delete_screensaver FlipFlop
delete_screensaver FlipScreen3D
delete_screensaver FlipText
delete_screensaver Flow
delete_screensaver Flurry
delete_screensaver FluidBalls
delete_screensaver FlyingToasters
delete_screensaver FontGlide
delete_screensaver FuzzyFlakes
delete_screensaver GFlux
delete_screensaver GLBlur
delete_screensaver GLCells
delete_screensaver GLHanoi
delete_screensaver GLKnots
#delete_screensaver GLMatrix
delete_screensaver GLPlanet
delete_screensaver GLSchool
delete_screensaver GLSlideshow
delete_screensaver GLSnake
delete_screensaver GLText
delete_screensaver Galaxy
delete_screensaver Gears
delete_screensaver Geodesic
delete_screensaver GeodesicGears
delete_screensaver Gleidescope
delete_screensaver GlitchPEG
delete_screensaver Goop
#delete_screensaver Grav
delete_screensaver Greynetic
delete_screensaver Halftone
delete_screensaver Halo
delete_screensaver Handsy
#delete_screensaver Helix
delete_screensaver Hexadrop
delete_screensaver Hexstrut
#delete_screensaver Hilbert
delete_screensaver Hopalong
delete_screensaver Hydrostat
delete_screensaver Hypertorus
delete_screensaver Hypnowheel
#delete_screensaver IFS
delete_screensaver IMSMap
#delete_screensaver Interaggregate
delete_screensaver Interference
delete_screensaver Intermomentary
delete_screensaver JigglyPuff
delete_screensaver Jigsaw
delete_screensaver Juggler3D
delete_screensaver Julia
delete_screensaver Kaleidescope
delete_screensaver Kaleidocycle
delete_screensaver Klein
delete_screensaver Kumppa
delete_screensaver LCDscrub
delete_screensaver Lament
delete_screensaver Lavalite
delete_screensaver Lockward
delete_screensaver Loop
#delete_screensaver m6502
#delete_screensaver Maze
#delete_screensaver Maze3D
#delete_screensaver MemScroller
delete_screensaver Menger
delete_screensaver MetaBalls
delete_screensaver MirrorBlob
delete_screensaver Moebius
delete_screensaver MoebiusGears
delete_screensaver Moire
delete_screensaver Moire2
delete_screensaver Molecule
delete_screensaver Morph3D
delete_screensaver Mountain
delete_screensaver Munch
delete_screensaver NerveRot
delete_screensaver Noof
delete_screensaver NoseGuy
#delete_screensaver Pacman
delete_screensaver Pedal
delete_screensaver Peepers
delete_screensaver Penetrate
delete_screensaver Penrose
delete_screensaver Petri
#delete_screensaver Phosphor.app
delete_screensaver Phosphor
delete_screensaver Photopile
delete_screensaver Piecewise
delete_screensaver Pinion
#delete_screensaver Pipes
delete_screensaver Polyhedra
#delete_screensaver Polyominoes
delete_screensaver Polytopes
#delete_screensaver Pong
delete_screensaver PopSquares
delete_screensaver ProjectivePlane
delete_screensaver Providence
delete_screensaver Pulsar
delete_screensaver Pyro
#delete_screensaver Qix
delete_screensaver QuasiCrystal
delete_screensaver Queens
delete_screensaver RDbomb
delete_screensaver RaverHoop
delete_screensaver RazzleDazzle
delete_screensaver Ripples
delete_screensaver Rocks
delete_screensaver RomanBoy
delete_screensaver Rorschach
delete_screensaver RotZoomer
delete_screensaver Rubik
delete_screensaver RubikBlocks
delete_screensaver SBalls
#delete_screensaver ShadeBobs
delete_screensaver Sierpinski
delete_screensaver Sierpinski3D
delete_screensaver SkyTentacles
delete_screensaver SlideScreen
delete_screensaver Slip
delete_screensaver Sonar
delete_screensaver SpeedMine
delete_screensaver Spheremonics
delete_screensaver SplitFlap
delete_screensaver Splodesic
delete_screensaver Spotlight
delete_screensaver Sproingies
delete_screensaver Squiral
delete_screensaver Stairs
#delete_screensaver StarWars
delete_screensaver Starfish
delete_screensaver StonerView
delete_screensaver Strange
#delete_screensaver Substrate
delete_screensaver Superquadrics
delete_screensaver Surfaces
delete_screensaver Swirl
delete_screensaver Tangram
delete_screensaver Tessellimage
delete_screensaver Thornbird
delete_screensaver TimeTunnel
delete_screensaver TopBlock
delete_screensaver Triangle
delete_screensaver TronBit
delete_screensaver Truchet
delete_screensaver Twang
delete_screensaver Unicrud
delete_screensaver UnknownPleasures
delete_screensaver VFeedback
delete_screensaver Vermiculate
delete_screensaver Vigilance
delete_screensaver Voronoi
delete_screensaver Wander
delete_screensaver WebCollage
#delete_screensaver WhirlWindWarp
delete_screensaver WindupRobot
#delete_screensaver Wormhole
delete_screensaver XAnalogTV
delete_screensaver XJack
delete_screensaver XLyap
delete_screensaver XFlame
#delete_screensaver XMatrix
delete_screensaver XRaySwarm
delete_screensaver XSpirograph
delete_screensaver Zoom
echo "Done"
