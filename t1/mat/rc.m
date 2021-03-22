close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

printf("----- Lab 01 -----\n\n");

printf("Defining numerical values\n");
R1 = 1.00330225563
R2 = 2.09791449329
R3 = 3.05015133481
R4 = 4.03383088683
R5 = 3.1055419384
R6 = 2.07443162776
R7 = 1.02510881122
Kb = 7.10627754609
Kc = 8.26237201768
Va = 5.10081122772
Id = 1.01322710556

printf("--->KCL:\n");
eq1 = [0, -1/R1, 1/R3 + 1/R1+1/R2, -1/R2, 0, 0, 0]
eq2 = [0, 0, -1/R2-Kb, 1/R2, 0, 0, 0]
eq3 = [0, 0, Kb, 0, 1/R5, 0, 0]
eq4 = [1/R6, 0, 0, 0, 0, 1/R7, -1/R6 - 1/R7]
eq5 = [1/R4 + 1/R6, 1/R1, -1/R1, 0, 0, 0,-1/R6]
eq6 = [-1, 1, 0, 0, 0, 0, 0]
eq7 = [Kc/R6, 0, 0, 0, 0, 1, -Kc/R6]
Nodal = [eq1; eq2; eq3; eq4; eq5; eq6; eq7]

sources = [0; 0; Id; 0; 0; Va; 0]

sol1 = Nodal\sources

printf("---> KVL\n");

Mesh=[R4+R3+R1, -R3, -R4; -R4, 0, -Kc+R6+R7+R4; -Kb*R3, -1+Kb*R3, 0]
sources = [-Va; 0; 0]
sol2 = Mesh\sources


%--->Printing files to .tex file for autamtic table input

%------>KCL
fileID1 = fopen('VecSolNode.tex', 'w');
fprintf(fileID1, "$$ V = ");
a = latex(vpa(sol1, 5));
fprintf(fileID1, "%s", a);
fprintf(fileID1, "$$");
fclose(fileID1);

%------>KVL
fileID2 = fopen('VecSolMesh.tex', 'w');
fprintf(fileID1, "$$ I = ");
a = latex(vpa(sol2, 6));
fprintf(fileID2, "%s\n", a);
fprintf(fileID2, "$$");
fclose(fileID2);

%------>Extra three currents
fileID3 = fopen('RCurrents.tex', 'w');
IR3 = sol2(2) - sol2(1)
fprintf(fileID3, "$$I_{R3} = %.7f mA$$\n", IR3);
IR4 = sol2(1) - sol2(3)
fprintf(fileID3, "$$I_{R4} = %f mA$$\n", IR4);
IR5 = Id - sol2(2)
fprintf(fileID3, "$$I_{R5} = %f mA$$\n", IR5);
fclose(fileID3)
