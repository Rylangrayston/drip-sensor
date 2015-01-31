dripGap = 5; 
outerWidth = 11;

sourceHoseDiameter = 3;
sourceHoseLength = 22;
drainHoseLength = 10;

upperDripContactLength = 0;// note also added to by the sourceHoseContactTipLength
sourceHoseContactTipLength = 10;
lowerDripContactLength = 4;

wallThickness = 2;


totalHeight = sourceHoseLength + upperDripContactLength + dripGap + lowerDripContactLength;

resolution = 40;

wireHoleDiameter = 2;

module sourceHoseContact()
{

		difference()
		{
			union()
			{
				square([wallThickness * 2 + sourceHoseDiameter, sourceHoseLength + upperDripContactLength]);
				translate([wallThickness  + sourceHoseDiameter/2,sourceHoseLength + upperDripContactLength,0])
					resize([0,2 * sourceHoseContactTipLength,0]) circle(d = wallThickness * 2 + sourceHoseDiameter, $fn = resolution);
			}
			translate([wallThickness,0,0])
				square([sourceHoseDiameter, sourceHoseLength]);
		
			translate([wallThickness  + sourceHoseDiameter/2,sourceHoseLength + upperDripContactLength + sourceHoseContactTipLength ,0])
			{
				circle(d = wireHoleDiameter, $fn = resolution); // wire holes:
				translate([0,-wireHoleDiameter*2,0])
				{	
					translate([0,-upperDripContactLength - sourceHoseContactTipLength ,0])
					square([.1,upperDripContactLength + sourceHoseContactTipLength]); // wicking grove 
					circle(d = wireHoleDiameter, $fn = resolution);	
				}
				translate([0,-wireHoleDiameter*4,0])
					circle(d = wireHoleDiameter, $fn = resolution);	
				

			}
		}
	

}

//resize([10,0,0], auto=[true,true,false]) cube([5,4,1]);

sourceHoseContact();