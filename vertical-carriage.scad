// Vertical carriage
// Created for the Echidna delta 3d printer
// https://github.com/bendetat/echidna

// This is based on the bumrail rod design using:
// - 608zz bearings
// - Traxxas 5347? rod ends
// - monofilament pulley with swivel connections
// - M8 bolts through the bearings to join the plates
// - M3 bolts for connecting swivels and endstop adjusters
// It could be adapted for T-Slot by adjusting the bearing outer
// diameter and making the internalToBearing and externalToBearing
// the same

$fn = 70;

//scaleFactorX = 1.17; // for sleeves
scaleFactorX = 1;
scaleFactorY = scaleFactorX;
scaleFactorZ = 1;

rodWidth = 15;
bearingOd = 22;
bearingId = 8;
bearingDepth = 6.94;
carriageDepth = 3.5;
distanceBetweenRodEnds = 34;	// outside distance between rod ends

smallBoltDiameter = 3;	// used for the Traxxas rod ends
untappedSmallBoltDiameter = 2.5;// used for the swivel holes, the endstop adjustor
pinDiameter = 1.75;	// using 1.75mm filament as a locking pin

// Distance from the carriage to the bearing (not including the bearing itself)
internalToBearing = 14;
externalToBearing = 16;
bearingSleeveThickness = 0.5;

carriageSize = rodWidth + bearingOd * 2;
smallBoltRadius = smallBoltDiameter / 2;
untappedSmallBoltRadius = untappedSmallBoltDiameter / 2;

scale([scaleFactorX,scaleFactorY,scaleFactorZ]) {
	//internalCarriage();
	externalCarriage();
	//bearingShaft();
	//bearingShaftSleeve();
	//bearingShaftSleeveInternal();
	//assembled();
	//rodEndJoint();
}

module assembled() {
	// one external carriage, one internal carriage, four bearing shafts
	// and four bearing shaft sleeves
	translate([0,0,carriageDepth+internalToBearing+bearingDepth+externalToBearing]) {
		rotate() {
			externalCarriage();
		}
	}
	translate([0,carriageSize,carriageDepth]) {
		rotate([180,0,0]) {
			internalCarriage();
		}
	}
	translate([bearingOd/2,bearingOd/2,0]) {
		assembledBearingShaft();
	}
	translate([carriageSize-bearingOd/2,bearingOd/2,0]) {
		assembledBearingShaft();
	}
	translate([bearingOd/2,carriageSize-bearingOd/2,0]) {
		assembledBearingShaft();
	}
	translate([carriageSize-bearingOd/2,carriageSize-bearingOd/2,0]) {
		assembledBearingShaft();
	}
}

module assembledBearingShaft() {
	bearingShaft();
	translate([0,0,carriageDepth+internalToBearing+bearingDepth]) {
		bearingShaftSleeve();
	}
}

module bearingShaft() {
	difference() {
		union() {
			cylinder(r=bearingId/2, h=internalToBearing+externalToBearing+bearingDepth+carriageDepth*2);
			translate([0,0,carriageDepth]) {
				cylinder(r=bearingId/2+bearingSleeveThickness, h=internalToBearing);
			}
		}
		// pin
		translate([0,(bearingId+2)/2,carriageDepth+internalToBearing+bearingDepth+(pinDiameter/2)]) {
			rotate([90,0,0]) {
				cylinder(r=pinDiameter/2, h=bearingId+2);
			}
		}
	}
}

module bearingShaftSleeve() {
	difference() {
		cylinder(r=bearingId/2+bearingSleeveThickness, h=externalToBearing);
		translate([0,0,-1]) {			
			cylinder(r=bearingId/2, h=externalToBearing+2);
		}
	}
}
module bearingShaftSleeveInternal() {
	difference() {
		cylinder(r=bearingId/2+bearingSleeveThickness, h=internalToBearing);
		translate([0,0,-1]) {			
			cylinder(r=bearingId/2, h=internalToBearing+2);
		}
	}
}

module externalCarriage() {
	adjustorHeight = 8;
	adjustorLength = 15;
	difference() {
		union() {
			basicCarriage();
			translate([carriageSize/2-adjustorHeight/2,0,carriageDepth]) {
				cube([adjustorHeight,adjustorLength,adjustorHeight]);
			}
			translate([carriageSize/2,adjustorLength,carriageDepth + adjustorHeight]){
				rotate([90,0,0]) {
					cylinder(r=adjustorHeight/2,h=adjustorLength);
				}
			}
		}
		translate([carriageSize/2,adjustorLength +1,carriageDepth + adjustorHeight]) {
			rotate([90,0,0]) {
				cylinder(r=untappedSmallBoltRadius,h=adjustorLength+2);
			}
		}
	}
}

module internalCarriage() {
	difference() {
		basicCarriage();
		// drill holes for pulley swivels		
		translate([carriageSize * 0.4, carriageSize / 10,-1]) {
			cylinder(r=untappedSmallBoltRadius, h=carriageDepth + 2);
		}
		translate([carriageSize * 0.6, 9 * carriageSize / 10,-1]) {
			cylinder(r=untappedSmallBoltRadius, h=carriageDepth + 2);
		}
	}
	translate([carriageSize/2-distanceBetweenRodEnds/2-1,carriageSize/2-7/2,carriageDepth]) {
		rodEndJoint();
	}
	translate([carriageSize/2+distanceBetweenRodEnds/2-1,carriageSize/2-7/2,carriageDepth]) {
		rodEndJoint();
	}
}

module basicCarriage() {
	difference() {
		// carriage with rounded corners
		union() {
			// carriage with corners cut out
			difference() {
				cube([carriageSize, carriageSize, carriageDepth]);
				translate([-1,-1,-1]) {
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageDepth + 2]);
				}
				translate([carriageSize - bearingOd / 2,-1,-1]) {
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageDepth + 2]);
				}
				translate([-1,carriageSize - bearingOd / 2,-1]) {
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageDepth + 2]);
				}
				translate([carriageSize - bearingOd / 2,carriageSize - bearingOd / 2,-	1]) 	{
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageDepth + 2]);
				}
			}
			//corners
			translate([bearingOd / 2,bearingOd / 2, 0]) {
				cylinder(r=bearingOd/2,h=carriageDepth);
			}
			translate([bearingOd / 2,bearingOd / 2 + carriageSize - bearingOd, 0]) {
				cylinder(r=bearingOd/2,h=carriageDepth);
			}
			translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2, 0]) {
				cylinder(r=bearingOd/2,h=carriageDepth);
			}
			translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2 + carriageSize - bearingOd, 0]) {
				cylinder(r=bearingOd/2,h=carriageDepth);
			}
		}

		// cut-outs for bolts
		translate([bearingOd / 2, bearingOd / 2, -1]) {
			cylinder(r=bearingId/2,h=carriageDepth + 2);
		}
		translate([bearingOd / 2,bearingOd / 2 + carriageSize - bearingOd, -1]) {
			cylinder(r=bearingId/2,h=carriageDepth + 2);
		}
		translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2, -1]) {
			cylinder(r=bearingId/2,h=carriageDepth + 2);
		}
		translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2 + carriageSize - bearingOd, -1]) {
			cylinder(r=bearingId/2,h=carriageDepth + 2);
		}
	}
}

module rodEndJoint() {
	jointThickness = 2;
	difference() {
		union() {
			cube([jointThickness,7,7+7/2]);
			translate([0,7/2,7+7/2]) {
				rotate([0,90,0]) {
					cylinder(r=3.5,h=jointThickness);
				}
			}
			// bulk up the sides for strength
			translate([jointThickness/2,7/2,0]) cylinder(r1=7/2,r2=0,h=8);
		}
		translate([-1,7/2,7+7/2]) {
			rotate([0,90,0]) {
				cylinder(r=smallBoltRadius, h=jointThickness + 2);
			}
		}
	}
}
