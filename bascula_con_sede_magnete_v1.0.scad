// inserire i dati nelle variabili premere F6 per generale il modello
// quindi File->Export->Export as STL..
// in fase di stampa rallentarla al 30-40% quando stampa solo l'asta per il magnete
// ================================================================================

//Base
larg_base = 34;
lung_base = 145;
sp_base = 4;

//Triangolo
base_tr = 10;
h_tr = 6;

//Foro perno
raggio = 1;

//Pareti
sp_pareti = 2;
h_pareti = 35;
piatto_superiore = 50;

//Colonna e supporto colonna
larg_colonna = 10;
larg_supporto = larg_colonna/2;
prof_colonna = 7;
prof_supporto = prof_colonna;
h_colonna = 18;

//Magneti
sp_magnete = 4;
r_magnete = 5;

$fn = 20;

render()
{
	union()
	{
		difference()
		{
			union()
			{
				//Base
				translate([-lung_base/2,0,0]) cube([lung_base,larg_base,sp_base], center=false);
				
				//Prisma
				translate([0,0,sp_base]) polyhedron
				(
					points = 
					[
						//Faccia anteriore
						[0,0,0],[base_tr/2,0,0],[0,0,h_tr],
						//Faccia posteriore
						[0,larg_base,0],[base_tr/2,larg_base,0],[0,larg_base,h_tr]
					],
					faces =
					[
						//Facce anteriore e posteriore
						[0,2,1],[3,4,5],
						//Facce verticali
						[2,0,3],[2,3,5],
						//Facce orizzontali
						[1,3,0],[1,4,3],
						//Facce oblique
						[1,2,5],[1,5,4]
					]
				);
	
				mirror([1,0,0])
				{
					//Prisma
					translate([0,0,sp_base]) polyhedron
					(
						points = 
						[
							//Faccia anteriore
							[0,0,0],[base_tr/2,0,0],[0,0,h_tr],
							//Faccia posteriore
							[0,larg_base,0],[base_tr/2,larg_base,0],[0,larg_base,h_tr]
						],
						faces =
						[
							//Facce anteriore e posteriore
							[0,2,1],[3,4,5],
							//Facce verticali
							[2,0,3],[2,3,5],
							//Facce orizzontali
							[1,3,0],[1,4,3],
							//Facce oblique
							[1,2,5],[1,5,4]
						]
					);
				}
				
				//Parete centrale
				translate([-sp_pareti/2,0,sp_base]) cube([sp_pareti,larg_base,h_pareti-sp_base]);
		
				//Pareti laterali
				translate([0,0,sp_base]) cube([piatto_superiore/2,sp_pareti,h_pareti-sp_base]);
				translate([piatto_superiore/2,0,sp_base]) polyhedron
				(
					points =
					[
						[0,0,0],[(lung_base/2)-(piatto_superiore/2),0,0],[0,0,h_pareti-sp_base],
						[0,sp_pareti,0],[(lung_base/2)-(piatto_superiore/2),sp_pareti,0],
						[0,sp_pareti,h_pareti-sp_base]	
					],
					faces =
					[
						[1,0,3,4],[2,1,4,5],[0,2,5,3],[3,5,4],[2,0,1]
					]
				);
		
				translate([0,larg_base-sp_pareti,0]) mirror([0,0,0])
				{
					cube([piatto_superiore/2,sp_pareti,h_pareti]);
					translate([piatto_superiore/2,0,sp_base]) polyhedron
					(
						points =
						[
							[0,0,0],[(lung_base/2)-(piatto_superiore/2),0,0],[0,0,h_pareti-sp_base],
							[0,sp_pareti,0],[(lung_base/2)-(piatto_superiore/2),sp_pareti,0],
							[0,sp_pareti,h_pareti-sp_base]	
						],
						faces =
						[
							[1,0,3,4],[2,1,4,5],[0,2,5,3],[3,5,4],[2,0,1]
						]
					);
				}
		
				mirror([1,0,0])
				{
					translate([0,0,sp_base]) cube([piatto_superiore/2,sp_pareti,h_pareti-sp_base]);
					translate([piatto_superiore/2,0,sp_base]) polyhedron
					(
						points =
						[
							[0,0,0],[(lung_base/2)-(piatto_superiore/2),0,0],
							[0,0,h_pareti-sp_base],
							[0,sp_pareti,0],[(lung_base/2)-(piatto_superiore/2),sp_pareti,0],
							[0,sp_pareti,h_pareti-sp_base]	
						],
						faces =
						[
							[1,0,3,4],[2,1,4,5],[0,2,5,3],[3,5,4],[2,0,1]
						]
					);
		
					translate([0,larg_base-sp_pareti,0]) mirror([0,0,0])
					{
						cube([piatto_superiore/2,sp_pareti,h_pareti]);
						translate([piatto_superiore/2,0,sp_base]) polyhedron
						(
							points =
							[
								[0,0,0],[(lung_base/2)-(piatto_superiore/2),0,0],
								[0,0,h_pareti-sp_base],	
								[0,sp_pareti,0],[(lung_base/2)-(piatto_superiore/2),sp_pareti,0],
								[0,sp_pareti,h_pareti-sp_base]	
							],
							faces =
							[
								[1,0,3,4],[2,1,4,5],[0,2,5,3],[3,5,4],[2,0,1]
							]
						);
					}
				}
			} //Stop union
			
			//Foro perno
			translate([0,0,4]) rotate([90,0,180])
			{
				cylinder(h=larg_base+5, r=raggio);
			}
					
		} //Fine parte bassa della bascula

		//Supporto colonna
		polyhedron
		(
			points =
			[
				[0,0,h_pareti],[larg_supporto,0,h_pareti],
				[0,prof_supporto,h_pareti],[larg_supporto,prof_supporto,h_pareti],
				[0,0,h_pareti-2*larg_supporto]
			],
			faces =
			[
				[1,0,2,3],[0,1,4],[1,3,4],[3,2,4],[2,0,4]
			]
		);
		mirror([1,0,0])
		{
			polyhedron
			(
				points =
				[
					[0,0,h_pareti],[larg_supporto,0,h_pareti],
					[0,prof_supporto,h_pareti],[larg_supporto,prof_supporto,h_pareti],
					[0,0,h_pareti-2*larg_supporto]
				],
				faces =
				[
					[1,0,2,3],[0,1,4],[1,3,4],[3,2,4],[2,0,4]
				]
			);
		}
	
		//Colonna
		difference()
		{
			translate([-larg_colonna/2,0,h_pareti]) cube([larg_colonna, prof_colonna, h_colonna]);
			translate([-sp_magnete/2,0,h_pareti+h_colonna-2*r_magnete]) cube([sp_magnete, prof_colonna, 2*r_magnete]);
		}
	}
}




