dripGap = 5; 
outerWidth = 11;
//$t =.5;
sourceHoseDiameter = 3;
sourceHoseLength = 12 + 10 * $t;
drainHoseLength = 10;

extendTipLength = 0;// makes the tip longer without making it pointier 
contactTipLength = 10 + 5 * $t; // as in the length of the pointy part, controls how pointy or blunt the tip is. 


wallThickness = 2;
echo($t);


totalHeight = sourceHoseLength + extendTipLength + dripGap + lowerDripContactLength;

resolution = 40;

wireHoleDiameter = 2;


module contactTip()
{

	difference()
	{
		translate([wallThickness  + sourceHoseDiameter/2,extendTipLength,0])
			resize([0,2 * contactTipLength,0])
				circle(d = wallThickness * 2 + sourceHoseDiameter, $fn = resolution);
		translate([0,-contactTipLength,0])
			square([wallThickness * 2 + sourceHoseDiameter, contactTipLength]);
	
		translate([wallThickness  + sourceHoseDiameter/2, extendTipLength + contactTipLength ,0])
		{
			circle(d = wireHoleDiameter, $fn = resolution); // wire holes:
			translate([0,-wireHoleDiameter*2,0])
			{	
				translate([0,-extendTipLength - contactTipLength ,0])
				square([.1,extendTipLength + contactTipLength]); // wicking grove 
				circle(d = wireHoleDiameter, $fn = resolution);	
			}
			translate([0,-wireHoleDiameter*4,0])
				circle(d = wireHoleDiameter, $fn = resolution);	
		}
	}
	

}



module sourceHoseAndContact()
{

	difference()
	{
		union()
		{
			square([wallThickness * 2 + sourceHoseDiameter, sourceHoseLength + extendTipLength]);
			translate([0,sourceHoseLength + extendTipLength,0])
				contactTip();
		}
		translate([wallThickness,0,0])
			square([sourceHoseDiameter, sourceHoseLength]);

	}
	

}





sourceHoseAndContact();
//contactTip();





