<?php

//Name of product used by the socle
define('PRODUCT', 'frogs-hopper');

$gameOptions = array(
	'duration' => 60,
	'pointEarned' => 10,
    'pointLost' => 5,
	'pointToLevel1' => 200,
    'winningLevel' =>1,
    'timingTemps'=> false,
    'percentToNextLevel' => 1.5,
    'life' => 3,
    'pointBonus' => 20,

    //Here You can add new specific parameters
    'jump_power' => .4, // better if : .2 < jump_power < .7

    // leaf_w & leaf_h are size of the waterlily leave
    // when it collide with sprite
    //
    // leaf #must be# :    0 < leaf_w < 180    &   10 < leaf_h < 50 ( leaf size: 180 x 100)
    // leaf_w  is fixed at the midle of the x axis of leaf
    // so it leaves some blank pixels at the extremities
    //
    // leaf_h is fixed at the bottom  and it leaves some blank pixels only on top 
    'leaf_w' => 60,
    'leaf_h' => 50



);

//REGIEREPLACE
