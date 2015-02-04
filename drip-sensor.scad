//$t =1;


dripGap = 9; 
outerWidth = 12;
sheetThickness = 3;
sourceHoseDiameter =(1/16) * 25.4+ .5;
sourceHoseLength = 20;
drainHoseLength = 10;
wireHoleDiameter = .7;
extendTipLength = 0;// makes the tip longer without making it pointier 
contactTipLength =6; // as in the length of the pointy part, controls how pointy or blunt the tip is. 


wallThickness = 1.7;
echo($t);

bottomTangLength = outerWidth-wallThickness ;
sourceHoseProtrusion= wallThickness * 2 + wireHoleDiameter + sheetThickness*2;
totalLength = sourceHoseLength + extendTipLength*2 +contactTipLength * 2 + dripGap + bottomTangLength - sourceHoseProtrusion;

resolution = 40;


tipWidth = wallThickness * 2 + sourceHoseDiameter;
wickGap = .2;

clipGap =.01;

sourceHoseRelifeHoleDiameter = sourceHoseDiameter *.7;





module contactTip()
{

	difference()
	{
		translate([tipWidth/2,extendTipLength,0])
			resize([0,2 * contactTipLength,0])
				circle(d = tipWidth, $fn = resolution);
		translate([0,-contactTipLength,0])
			square([tipWidth, contactTipLength]);
	
		translate([tipWidth/2, extendTipLength + contactTipLength ,0])
		{
			circle(d = wireHoleDiameter, $fn = resolution); // wire holes:
			translate([0,-wireHoleDiameter*2,0])
			{	
				translate([-wickGap/2,-extendTipLength - contactTipLength ,0])
				square([wickGap,extendTipLength + contactTipLength]); // wicking grove 
				circle(d = wireHoleDiameter, $fn = resolution);	
			}
			translate([0,-wireHoleDiameter*4,0])
				circle(d = wireHoleDiameter, $fn = resolution);	
	
		}
		

	}
	

}



module sourceHoseContact()
{

	difference()
	{
		union()
		{
			square([wallThickness * 2 + sourceHoseDiameter, sourceHoseLength + extendTipLength]);

		}
		translate([wallThickness,0,0])
			square([sourceHoseDiameter, sourceHoseLength]);



	}
	

}
//#square([outerWidth,wallThickness]);

module cutBridge(cut)
{
difference()
	{
	square([outerWidth,wallThickness*2]);
	translate([outerWidth/2 - cut/2,0,0])
		square([cut,wallThickness*2]);
	}
}

module topCutBridge()
{
difference()
	{
	translate([-clipGap-wallThickness,0,0])
	square([outerWidth+clipGap+wallThickness,wireHoleDiameter * 3]);
	translate([outerWidth/2 - sourceHoseDiameter/2,0,0])
		square([sourceHoseDiameter,wireHoleDiameter * 3]);
	translate([0,wireHoleDiameter * 1.5,0])
		{
		translate([outerWidth-(outerWidth/2 - sourceHoseDiameter/2)/2 ,0,0])
			circle(d = wireHoleDiameter, $fn = resolution );
		translate([(outerWidth/2 - sourceHoseDiameter/2)/2 ,0,0])
			circle(d = wireHoleDiameter, $fn = resolution );		
		}

	}
}
//topCutBridge();
//cutBridge(cut = 3);

//sourceHoseContact();
//contactTip();

module outerBody()
{
union()
	{
	square([wallThickness,totalLength]); // outer side wall
	translate([outerWidth-wallThickness,0,0])
		square([wallThickness,totalLength]); // outer side wall
	translate([-clipGap - wallThickness,0,0])
		square([wallThickness,totalLength]);// clip wall


	translate([outerWidth/2-tipWidth/2,bottomTangLength,0])
		contactTip(); // bottom contactTip()
	translate([0,bottomTangLength - wallThickness,0])
		cutBridge(cut = wickGap);
	difference()
	{	
		translate([outerWidth/2+tipWidth/2,bottomTangLength+ contactTipLength*2 + dripGap,0])
			rotate(180)
			contactTip(); // top contactTip()
		translate([outerWidth/2,bottomTangLength+ contactTipLength*2 + dripGap,0])
			circle(d = sourceHoseRelifeHoleDiameter, $fn = resolution); // so that you cant pug the hose on a flat surface. 
	}
	translate([outerWidth/2-tipWidth/2,bottomTangLength+ contactTipLength*2 + dripGap,0])
	sourceHoseContact();
	translate([0,totalLength,0])
	topCutBridge();
	}
}
outerBody();
module dripSensor()
{
	
}