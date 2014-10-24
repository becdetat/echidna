// Vertical carriage
// Created for the Echidna delta 3d printer
// https://github.com/bendetat/echidna

// This is based on the bumrail rod design using:
// - 608zz bearings
// - Traxxas 5347? rod ends
// - monofilament pulley with swivel connections
// - M8 bolts through the bearings to join the plates
// - M3 bolts for connecting swivels and endstop adjusters

rodWidth = 20;
bearingOd = 22;
bearingId = 8;
carriageThickness = 6;
smallBoltDiameter = 3;	// used for the Traxxas rod ends
untappedSmallBoltDiameter = 2.5;// used for the bearing holes, the endstop adjustor
distanceBetweenRodEnds = 34;	// outside distance between rod ends

carriageSize = rodWidth + bearingOd * 2;
smallBoltRadius = smallBoltDiameter / 2;
untappedSmallBoltRadius = untappedSmallBoltDiameter / 2;

//internalCarriage();
externalCarriage();

module externalCarriage() {
	adjustorHeight = 8;
	adjustorLength = 15;
	difference() {
		union() {
			basicCarriage();
			translate([carriageSize/2-adjustorHeight/2,0,carriageThickness]) {
				cube([adjustorHeight,adjustorLength,adjustorHeight]);
			}
			translate([carriageSize/2,adjustorLength,carriageThickness + adjustorHeight]){
				rotate([90,0,0]) {
					cylinder(r=adjustorHeight/2,h=adjustorLength);
				}
			}
		}
		translate([carriageSize/2,adjustorLength +1,carriageThickness + adjustorHeight]) {
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
			cylinder(r=untappedSmallBoltRadius, h=carriageThickness + 2);
		}
		translate([carriageSize * 0.6, 9 * carriageSize / 10,-1]) {
			cylinder(r=untappedSmallBoltRadius, h=carriageThickness + 2);
		}
	}
	translate([carriageSize/2-distanceBetweenRodEnds/2-1,carriageSize/2-7/2,carriageThickness]) {
		rodEndJoint();
	}
	translate([carriageSize/2+distanceBetweenRodEnds/2-1,carriageSize/2-7/2,carriageThickness]) {
		rodEndJoint();
	}
}

module basicCarriage() {
	difference() {
		// carriage with rounded corners
		union() {
			// carriage with corners cut out
			difference() {
				cube([carriageSize, carriageSize, carriageThickness]);
				translate([-1,-1,-1]) {
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageThickness + 2]);
				}
				translate([carriageSize - bearingOd / 2,-1,-1]) {
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageThickness + 2]);
				}
				translate([-1,carriageSize - bearingOd / 2,-1]) {
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageThickness + 2]);
				}
				translate([carriageSize - bearingOd / 2,carriageSize - bearingOd / 2,-	1]) 	{
					cube([bearingOd/2 + 1, bearingOd/2 + 1, carriageThickness + 2]);
				}
			}
			//corners
			translate([bearingOd / 2,bearingOd / 2, 0]) {
				cylinder(r=bearingOd/2,h=carriageThickness);
			}
			translate([bearingOd / 2,bearingOd / 2 + carriageSize - bearingOd, 0]) {
				cylinder(r=bearingOd/2,h=carriageThickness);
			}
			translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2, 0]) {
				cylinder(r=bearingOd/2,h=carriageThickness);
			}
			translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2 + carriageSize - bearingOd, 0]) {
				cylinder(r=bearingOd/2,h=carriageThickness);
			}
		}

		// cut-outs for bolts
		translate([bearingOd / 2, bearingOd / 2, -1]) {
			cylinder(r=bearingId/2,h=carriageThickness + 2);
		}
		translate([bearingOd / 2,bearingOd / 2 + carriageSize - bearingOd, -1]) {
			cylinder(r=bearingId/2,h=carriageThickness + 2);
		}
		translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2, -1]) {
			cylinder(r=bearingId/2,h=carriageThickness + 2);
		}
		translate([bearingOd / 2 + carriageSize - bearingOd, bearingOd / 2 + carriageSize - bearingOd, -1]) {
			cylinder(r=bearingId/2,h=carriageThickness + 2);
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
		}
		translate([-1,7/2,7+7/2]) {
			rotate([0,90,0]) {
				cylinder(r=smallBoltRadius, h=jointThickness + 2);
			}
		}
	}
}
