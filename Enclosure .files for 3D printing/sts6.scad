// author Tomáš Svatoň
// units [mm]

module sts6(lenBody,leng,diam,diamNodes,halfExt) {
    translate([0,0,halfExt])
    union() {
        cylinder(h=lenBody,d=diam,center=true,$fn=100) ;
        cylinder(h=leng,d=diamNodes,center=true,$fn=100) ;
    }
}

module sts6cup(lenBody,leng,diam,diamNodes,cupLen,cupTh,diamInc,halfExt,showCut) {
difference() {
    translate([0,0,halfExt])
difference() {
    union() {
        translate([0,0,lenBody/2-diamNodes/5]) sphere(d=diam+diamInc+cupTh,$fn=100) ;
        cylinder(h=lenBody/2-diamNodes/5,d=diam+diamInc+cupTh,center=false,$fn=100) ;
        translate([0,0,-halfExt]) cylinder(h=halfExt,d=diam+diamInc+cupTh,center=false,$fn=100) ; // extension
    }
    union() {
        cylinder(h=lenBody+diamInc,d=diam+diamInc,center=true,$fn=100) ;
        cylinder(h=leng+diamInc,d=diamNodes+diamInc+1,center=true,$fn=100) ;
        translate([0,0,-halfExt]) cylinder(h=halfExt,d=diamNodes+diamInc+1,center=true,$fn=100) ; // extension
    }
}
if(showCut==true) {
    translate([0,0,-diam]) cube([2*diam,2*diam,leng]) ;
}
}
}

module cup(cl,cw,ch,wt) {
    difference() {
        cube([cl,cw,ch]) ;
        translate([wt,wt,-0.01]) cube([cl-2*wt,cw-2*wt,ch-wt]) ;
    }
}

module box(bl,bw,bh,wt,hu,hv,hx,hy,srx,sry,srw) {
difference() {
    union() {
difference() { // principal box
    translate([0,0,-bh]) cube([bl,bw,bh]) ;
    translate([wt,wt,-bh+wt+0.01]) cube([bl-2*wt,bw-2*wt,bh-wt]) ;
}
translate([hu-srw+(hx-srx)/2,hv-srw+(hy-sry)/2,-bh+wt])
difference() { //rectangle ring
    cube([2*srw+srx,2*srw+sry,wt]) ;
    translate([srw,srw,-0.01]) cube([srx,sry,wt+0.02]) ;
}
}
translate([hu,hv,-bh-0.01]) cube([hx,hy,bh+wt]) ; // principal hole
}
}

module lcd(lpl,lpw,lph,ldl,ldw,ldh,ldu,ldv) {
    translate([0,(lpw-ldw)-ldv,ldh]) cube([lpl,lpw,lph]) ;
    translate([ldu,ldv,0]) cube([ldl,ldw,ldh]) ;
}

module wedge(wr,wl,wrot) {
difference() {
    translate([0,-wr/2,wr/2]) rotate([0,90,wrot]) cylinder(h=1.6*wl,r1=wr,r2=wr,$fn=3) ;
    union() {
        translate([-wr,-wr,-1.1*wr]) cube([3*wr,wr,2.5*wr]) ;
        translate([wr-wr/2,wl,-1.1*wr]) cube([3*wr,wr,2.5*wr]) ;
    }
}
}

module nipple(nh,dh) {
    union() {
    cylinder(h=nh,d1=dh,d2=dh,$fn=100) ;
    cylinder(h=nh+2.5,d1=1.9,d2=1.9,$fn=100) ;
    translate([dh/2,0,6]) rotate([0,-90,90]) cylinder(h=1.8,d1=dh,d2=dh,center=true,$fn=3) ;
    translate([0,dh/2,6]) rotate([0,-90,0]) cylinder(h=1.8,d1=dh,d2=dh,center=true,$fn=3) ;
    translate([0,3,dh/2]) cube([1.8,3,5],center=true) ;
    translate([3,0,dh/2]) rotate([0,0,90]) cube([1.8,3,5],center=true) ;    
    }
}

module radioactive(xh,xd,xcd) {
    for(angles=[0:120:240]) {
        rotate([0,0,angles])
    difference() {
    cylinder(h=xh,d1=xd,d2=xd,$fn=100) ;
    union() {
        rotate([0,0,30]) translate([0,-xd/2,-0.01]) cube([xd,xd,xh+0.02]) ;
        rotate([0,0,-210]) translate([0,-xd/2,-0.01]) cube([xd,xd,xh+0.02]) ;
        translate([0,0,-0.01]) cylinder(h=xh+0.02,d1=xcd+1.2,d2=xcd+1.2,$fn=100) ;
    }
}
}
cylinder(h=xh,d1=xcd,d2=xcd,$fn=100) ;
}

module cutFrame(bxl,bxw,wth,cfh) {
    difference() { // to obtain inner edges
        translate([-0.01,-0.01,0]) cube([bxl+0.02,bxw+0.02,cfh]) ;
    translate([wth/2,wth/2,-0.01]) cube([bxl-wth-0.4,bxw-wth-0.4,cfh+0.02]) ;
    }
}

module cutCupInside(cnHght,cnBsDm,cnTpDm,pllwHght) {
    union() {
        cylinder(h=cnHght,d1=cnBsDm,d2=cnTpDm,$fn=100) ;
        translate([0,0,cnHght]) scale([cnTpDm,cnTpDm,pllwHght]) difference() { sphere(d=1,$fn=100) ; translate([-.5,-.5,-1]) cube([1,1,1]) ; }
    }
}


// wedge
wedr=4 ;
wedl=16 ;
wedrot=60 ;

// lcd
lcdpl=94 ;
lcdpw=43 ;
lcdph=1 ;
lcddl=71 ;
lcddw=24 ;
lcddh=11 ;
lcddu=17 ;
lcddv=12.5 ;

// sts6
sts6Len=196 ;
sts6LenBody=182 ;
sts6Diam=18 ;
sts6DiamNodes=6 ;

// sts6 cup
sts6CupLen=50 ;
sts6CupTh=2 ;
sts6DiamInc=2 ;
sts6HalfExt = 10 ; // extension to half length of sts6
sts6ShowCut=false ;

// cut frame
cutFrameH=3 ;

// box
wallth=1.6 ;
boxl=120 ;
boxw=60+7 ;
boxh=24 ;

holeu=23.5 ;
holev=14 ;
holex=63 ;
holey=12 ;

sqringx=72 ;
sqringy=25.5 ;
sqringw=4 ;

// box cup
cupl=120 ;
cupw=boxw ;
cuph=11 ;

// cut cup inside parameters
coneBaseDiam=sts6Diam+sts6DiamInc ;
coneTopDiam=sts6DiamNodes+sts6DiamInc+1 ;
coneHeight=0.5*(sts6Len-sts6LenBody) ;
pillowHeight=.3*coneTopDiam ;


// lcd - debug
//translate([wallth+0.5,-2*wallth,-boxh+wallth+0.5]) lcd(lcdpl,lcdpw,lcdph,lcddl,lcddw,lcddh,lcddu,lcddv) ;

// sts6 - debug
//translate([0,boxw-sts6Diam/2-wallth*1.5,-sts6Diam/3]) rotate([0,-90,0]) sts6(sts6LenBody,sts6Len,sts6Diam,sts6DiamNodes,sts6HalfExt) ;

// four parts to be printed: box 2, cover 1, cup 3 and hole cover 0

SHOW_CUP_STS6_HOLE=0 ;
SHOW_BOX_COVER=1 ;
SHOW_BOX_BASE=2 ;
SHOW_STS6_CUP=3 ;
SHOW_STS6_AND_BOX=4 ;
SHOW_STS6_AND_COVER=5 ;
SHOW_BOX_AND_COVER=6 ;
SHOW_ALL=7 ;

show=SHOW_ALL ;

if(show==SHOW_ALL || show==SHOW_BOX_AND_COVER || show==SHOW_STS6_AND_COVER || show==SHOW_BOX_COVER)
{
// --> all for box cover
// cup
translate([0,-cupw*1.2*0,-cutFrameH])
difference() {
    cup(cupl,cupw,cuph,wallth) ;
    
    union() {
        translate([94,42,0]) cylinder(h=22,d1=5,d2=5,$fn=100) ; // hollow cyl
        translate([5,5,0]) cylinder(h=22,d1=5,d2=5,$fn=100) ; // hollow cyl
        translate([0,0,-0.01]) cutFrame(boxl+0.01,boxw+0.01,wallth,cutFrameH) ; // cut frame
    for (dx=[0:2/3*boxl/10:2/3*boxl]) translate([2*wallth+dx,cupw-wedl-wallth,cuph-3]) wedge(wedr,wedl,wedrot) ;
     translate([-0.01,boxw-sts6Diam/2-wallth*1.5,-sts6Diam/3+cutFrameH]) rotate([0,90,0]) cylinder(h=wallth+0.02,d1=sts6Diam+sts6DiamInc+2.3*wallth,d2=sts6Diam+sts6DiamInc+2.3*wallth,$fn=100) ; // to pass sts6 cup
}

}
translate([94,42,-cutFrameH]) difference() { cylinder(h=cuph,d1=7,d2=7,$fn=100) ; translate([0,0,-cutFrameH-0.01]) cylinder(h=22,d1=5,d2=5,$fn=100) ; } // hollow cyl
translate([5,5,-cutFrameH]) difference() { cylinder(h=cuph,d1=7,d2=7,$fn=100) ; translate([0,0,-cutFrameH-0.01]) cylinder(h=22,d1=5,d2=5,$fn=100) ; } // hollow cyl
translate([98,1,-cutFrameH]) cube([2,44,cuph]) ; // battery
translate([wallth,0.67*cupw,-cutFrameH+.4]) rotate([-10,0,0]) cube([0.7*cupl,wallth,0.9*cuph]) ; // sts6 lateral support
translate([0.685*cupl,0.78*cupw,-cutFrameH+0.32*cuph]) rotate([0,-90,0]) resize([0.9*cuph,12,1]) cylinder(h=wallth,d1=1,d2=1,center=true,$fn=3) ; // sts6 fixation
} // end if


if(show==SHOW_ALL || show==SHOW_STS6_AND_COVER || show==SHOW_STS6_AND_BOX || show==SHOW_STS6_CUP)
{
// --> all for sts6cup
difference() {
    translate([wallth,boxw-sts6Diam/2-wallth*1.5,-sts6Diam/3]) rotate([0,-90,0]) sts6cup(sts6LenBody+wallth,sts6Len+wallth,sts6Diam,sts6DiamNodes,sts6CupLen,sts6CupTh,sts6DiamInc,sts6HalfExt,sts6ShowCut) ;
    union() {
    for (dx=[0:2/3*boxl/10:2/3*boxl]) translate([-3*wedr-wallth-dx,boxw-wedl-sts6Diam/4.5,sts6Diam/8]) wedge(wedr,wedl,wedrot) ;
    translate([-2.021*sts6CupLen,boxw-sts6Diam/2-wallth*1.5,-sts6Diam/3]) rotate([0,-90,0]) cutCupInside(coneHeight,coneBaseDiam,coneTopDiam,pillowHeight) ;
    }
    }
} // end if


if(show==SHOW_ALL || show==SHOW_BOX_AND_COVER || show==SHOW_STS6_AND_BOX || show==SHOW_BOX_BASE )
{
// --> all for box
union() {
translate([wallth*2,boxw-2*wallth-6-18,-boxh+wallth]) linear_extrude(0.8) text("tsvaton@gmail.com",size=7.8) ;
// nipples for lcd
translate([17,5,-boxh]) nipple(9,5) ;
translate([17,36,-boxh]) rotate([0,0,-90]) nipple(9,5) ;
translate([92,36,-boxh]) rotate([0,0,180]) nipple(9,5) ;
translate([92,5,-boxh]) rotate([0,0,90]) nipple(9,5) ;
difference() { // ring for fixing sts6cup
    translate([-3*wallth+0.01,boxw-sts6Diam/2-wallth*1.5,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=4*wallth,d1=sts6Diam+sts6DiamInc+2*wallth,d2=sts6Diam+sts6DiamInc+2*wallth,$fn=100) ;
    translate([-3*wallth,boxw-sts6Diam/2-wallth*1.5,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=4*wallth+0.02,d1=sts6Diam+sts6DiamInc+1.3*wallth,d2=sts6Diam+sts6DiamInc+1.3*wallth,$fn=100) ; // to pass sts6
    }
// box
difference() {
    box(boxl,boxw,boxh,wallth,holeu,holev,holex,holey,sqringx,sqringy,sqringw) ;
    union()
    {
    translate([-0.01,boxw-sts6Diam/2-wallth*1.5,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=wallth+0.02,d1=sts6Diam+sts6DiamInc+1.3*wallth,d2=sts6Diam+sts6DiamInc+1.3*wallth,$fn=100) ; // hole in the wall to attach sts6 cup
    translate([9,14,-boxh-2]) radioactive(8,15,3) ; // radioactivity embleme
    translate([wallth/2,wallth/2,-3+0.01]) cube([boxl-wallth,boxw-wallth,3]) ; // closing border
    translate([58.4,boxw-wallth-0.5,-6.2-13.85]) cube([18.6,3,6.2]) ; // hole at border
    translate([-0.5,36,-15]) rotate([0,90,0]) cylinder(h=3,d1=5.5,d2=5.5,$fn=100) ; // left button hole
    translate([-0.5,27.4,-15]) rotate([0,90,0]) cylinder(h=3,d1=5.5,d2=5.5,$fn=100) ; // right button hole
    translate([-0.5,11,-5.75-3.65]) cube([3,10,3.65]) ; // hole at border with switches
    translate([14,-0.2,-3.6-4]) cube([16,wallth,3.6]) ; // semi hole for pins at border
    translate([11.2,28,-boxh-0.5]) rotate([0,0,0]) cylinder(h=3,d1=4.5,d2=4.5,$fn=100) ; // led hole above
    translate([11.2,37,-boxh-0.5]) rotate([0,0,0]) cylinder(h=3,d1=4.5,d2=4.5,$fn=100) ; // led hole below
    translate([32,37,-boxh-0.5]) rotate([0,0,0]) cylinder(h=5,d1=4.5,d2=4.5,$fn=100) ; // popcorn hole below
    translate([boxl-2-0.01,boxw-wallth-sts6Diam/2-sts6DiamInc/2,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=4,d1=sts6Diam+sts6DiamInc,d2=sts6Diam+sts6DiamInc,$fn=100) ; // hole in the wall to enter sts6 tube
}
}
translate([2,3+22,1.4-10]) rotate([0,-90,90]) cylinder(h=3,d1=4,d2=4,$fn=3) ; // teeth at buttons
translate([96.7,wallth+2,-14-7.41-wallth]) cube([2,15,14]) ; // battery separator above
translate([96.7,wallth+2+15+2,-14-7.41-wallth]) cube([2,6,14]) ; // battery separator mid
difference() {
translate([96.7,wallth+2+15+2+6+2,-14-7.41-wallth]) cube([2,19,14]) ; // battery separator below
translate([boxl-2-0.01-22,boxw-wallth-sts6Diam/2-sts6DiamInc/2,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=4,d1=sts6Diam+4*sts6DiamInc,d2=sts6Diam+4*sts6DiamInc,$fn=100) ;
}
translate([96.7+1.99,wallth+2+6,-13]) cube([2,2,2]) ; // battery nib separator above
translate([96.7+1.99,wallth+2+33,-13]) cube([2,2,2]) ; // battery nib separator below
translate([96.7,3+22,1.4-11]) rotate([0,-90,90]) cylinder(h=3,d1=2,d2=2,$fn=3) ; // teeth at mid battery separator
translate([wallth+2.5,wallth+2.5,-boxh-0.01+wallth]) difference() { cylinder(h=11,d1=5,d2=5,$fn=100) ; translate([0,0,0.01]) cylinder(h=11,d1=1,d2=1,$fn=100) ; } // hollow cylinder 
translate([94,41.7,-boxh-0.01+wallth]) difference() { cylinder(h=11,d1=5,d2=5,$fn=100) ; translate([0,0,-0.1]) cylinder(h=11.2,d1=1,d2=1,$fn=100) ; } // hollow cylinder 
translate([94,41.7,-boxh]) rotate([0,0,90]) nipple(3,5) ; // (3,5) to keep the hole
// the bed for the sts6 tube -- really it could be nicer
translate([78,boxw-(sts6Diam+sts6CupTh+sts6DiamInc)+1,-wallth]) 
difference() { translate([0,0,-(boxh-2*wallth)]) cube([5,sts6Diam+sts6CupTh+sts6DiamInc-1,boxh-6*wallth]) ;
    union() {
        translate([-0.01,sts6Diam/2,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=6,d1=sts6DiamNodes*3.0,d2=sts6DiamNodes*3.0,$fn=100) ;
        translate([-0.01,-0.01,-sts6Diam/2+0.01]) cube([6,sts6Diam*0.7,sts6Diam]) ; // to enter the tube
        translate([-0.01,sts6Diam/2,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=4,d1=sts6Diam+sts6DiamInc,d2=sts6Diam+sts6DiamInc,$fn=100) ;
       translate([-0.01,sts6Diam/2-0.01,-3]) cube([6,sts6Diam*0.7,sts6Diam]) ; // to cut above
        } }
}
} // end if


if(show==SHOW_ALL || show==SHOW_CUP_STS6_HOLE)
{
// --> cup for the sts6 inserting hole
difference() {
union() {
translate([boxl-wallth-0.01,boxw-wallth-sts6Diam/2-sts6DiamInc/2,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=wallth,d1=sts6Diam+sts6DiamInc,d2=sts6Diam+sts6DiamInc,$fn=100) ; // cetnral filling for the wall
translate([boxl-1.4*wallth-0.01,boxw-wallth-sts6Diam/2-sts6DiamInc/2,-sts6Diam/3]) rotate([0,90,0]) cylinder(h=0.4*wallth,d1=sts6Diam+sts6DiamInc+wallth,d2=sts6Diam+sts6DiamInc+wallth,$fn=100) ; // inner constraint
}
union() {
translate([0,boxw-wallth,-boxh]) cube([boxl,wallth,boxh]) ; // lateral box cut
translate([boxl-2*wallth,0,]) cube([wallth*2,boxw,boxh]) ; // upper cut
translate([boxl-2*wallth-wallth/2,0,-cutFrameH]) cube([wallth*2,boxw,boxh]) ; // small stair
}
}
}