dripGap = 5; 
outerWidth = 11;

sourceHoseDiameter = 3;
sourceHoseLength = 22;
drainHoseLength = 10;

uperDripContactLength = 2;
lowerDripContactLength = 4;

wallThickness = 2;


totalHeight = sourceHoseLength + uperDripContactLength + dripGap + lowerDripContactLength;

module sourceHoseContact()
{
square([10,20]);
}



sourceHoseContact();