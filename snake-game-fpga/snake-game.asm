jmp InitGame

; Variáveis
SnakePos: var #1               ; Posição atual da cobra
SnakeTailPos: var #1           ; Posição anterior da cobra
FoodIndex: var #1              ; Índice para o array de posição da comida
FoodPos: var #1                ; Posição atual da comida
LastKey: var #1                ; Última tecla AWSD pressionada, usada para manter o movimento
Length: var #1                 ; Comprimento da cobra
SnakeBody: var #300            ; Armazena as posições do corpo da cobra

; Variáveis de score
UnitScore: var #1
TenScore: var #1
HundredScore: var #1
; Valores iniciais
static UnitScore, #'0'
static TenScore, #'0'
static HundredScore, #'0'

; O cálculo da aleatoriedade das frutas no jogo é feito utilizando uma lista predefinida de posições (pseudo-aleatória). 
; Cada vez que a cobra come uma fruta, o índice (FoodIndex) é incrementado, apontando para a próxima posição na lista Food. 
; A posição da fruta é então atualizada acessando o valor na lista usando esse índice. 
; Isso garante consistência e evita a complexidade de gerar números aleatórios em tempo real.
Food: var #1200
static Food + #0, #536
static Food + #1, #1097
static Food + #2, #1020
static Food + #3, #620
static Food + #4, #451
static Food + #5, #1078
static Food + #6, #772
static Food + #7, #1047
static Food + #8, #976
static Food + #9, #565
static Food + #10, #490
static Food + #11, #515
static Food + #12, #175
static Food + #13, #350
static Food + #14, #510
static Food + #15, #165
static Food + #16, #275
static Food + #17, #605
static Food + #18, #726
static Food + #19, #654
static Food + #20, #938
static Food + #21, #766
static Food + #22, #841
static Food + #23, #391
static Food + #24, #163
static Food + #25, #990
static Food + #26, #388
static Food + #27, #450
static Food + #28, #331
static Food + #29, #534
static Food + #30, #1038
static Food + #31, #847
static Food + #32, #989
static Food + #33, #968
static Food + #34, #216
static Food + #35, #194
static Food + #36, #567
static Food + #37, #485
static Food + #38, #913
static Food + #39, #751
static Food + #40, #207
static Food + #41, #628
static Food + #42, #407
static Food + #43, #572
static Food + #44, #1051
static Food + #45, #885
static Food + #46, #945
static Food + #47, #402
static Food + #48, #607
static Food + #49, #258
static Food + #50, #725
static Food + #51, #550
static Food + #52, #463
static Food + #53, #291
static Food + #54, #949
static Food + #55, #431
static Food + #56, #796
static Food + #57, #643
static Food + #58, #794
static Food + #59, #979
static Food + #60, #1014
static Food + #61, #975
static Food + #62, #300
static Food + #63, #267
static Food + #64, #1056
static Food + #65, #710
static Food + #66, #481
static Food + #67, #1048
static Food + #68, #314
static Food + #69, #532
static Food + #70, #763
static Food + #71, #542
static Food + #72, #1023
static Food + #73, #1044
static Food + #74, #555
static Food + #75, #354
static Food + #76, #386
static Food + #77, #340
static Food + #78, #478
static Food + #79, #994
static Food + #80, #797
static Food + #81, #665
static Food + #82, #382
static Food + #83, #269
static Food + #84, #337
static Food + #85, #557
static Food + #86, #1104
static Food + #87, #943
static Food + #88, #948
static Food + #89, #728
static Food + #90, #822
static Food + #91, #531
static Food + #92, #624
static Food + #93, #881
static Food + #94, #409
static Food + #95, #1063
static Food + #96, #283
static Food + #97, #983
static Food + #98, #972
static Food + #99, #525
static Food + #100, #958
static Food + #101, #365
static Food + #102, #929
static Food + #103, #577
static Food + #104, #831
static Food + #105, #708
static Food + #106, #818
static Food + #107, #771
static Food + #108, #201
static Food + #109, #435
static Food + #110, #593
static Food + #111, #294
static Food + #112, #677
static Food + #113, #215
static Food + #114, #462
static Food + #115, #1010
static Food + #116, #816
static Food + #117, #564
static Food + #118, #753
static Food + #119, #211
static Food + #120, #658
static Food + #121, #325
static Food + #122, #898
static Food + #123, #579
static Food + #124, #210
static Food + #125, #649
static Food + #126, #568
static Food + #127, #1087
static Food + #128, #196
static Food + #129, #422
static Food + #130, #830
static Food + #131, #1036
static Food + #132, #357
static Food + #133, #326
static Food + #134, #805
static Food + #135, #584
static Food + #136, #276
static Food + #137, #547
static Food + #138, #987
static Food + #139, #798
static Food + #140, #695
static Food + #141, #874
static Food + #142, #1019
static Food + #143, #1102
static Food + #144, #379
static Food + #145, #511
static Food + #146, #433
static Food + #147, #1109
static Food + #148, #1107
static Food + #149, #928
static Food + #150, #457
static Food + #151, #651
static Food + #152, #735
static Food + #153, #894
static Food + #154, #780
static Food + #155, #1108
static Food + #156, #214
static Food + #157, #349
static Food + #158, #946
static Food + #159, #854
static Food + #160, #604
static Food + #161, #705
static Food + #162, #459
static Food + #163, #686
static Food + #164, #370
static Food + #165, #282
static Food + #166, #343
static Food + #167, #917
static Food + #168, #569
static Food + #169, #251
static Food + #170, #1029
static Food + #171, #896
static Food + #172, #701
static Food + #173, #832
static Food + #174, #259
static Food + #175, #204
static Food + #176, #638
static Food + #177, #714
static Food + #178, #985
static Food + #179, #295
static Food + #180, #668
static Food + #181, #627
static Food + #182, #891
static Food + #183, #452
static Food + #184, #234
static Food + #185, #642
static Food + #186, #523
static Food + #187, #845
static Food + #188, #1100
static Food + #189, #869
static Food + #190, #302
static Food + #191, #746
static Food + #192, #792
static Food + #193, #1061
static Food + #194, #363
static Food + #195, #614
static Food + #196, #587
static Food + #197, #310
static Food + #198, #915
static Food + #199, #1012
static Food + #200, #426
static Food + #201, #663
static Food + #202, #712
static Food + #203, #212
static Food + #204, #802
static Food + #205, #730
static Food + #206, #487
static Food + #207, #807
static Food + #208, #1004
static Food + #209, #1002
static Food + #210, #1083
static Food + #211, #414
static Food + #212, #857
static Food + #213, #873
static Food + #214, #1067
static Food + #215, #248
static Food + #216, #471
static Food + #217, #747
static Food + #218, #1094
static Food + #219, #436
static Food + #220, #174
static Food + #221, #1082
static Food + #222, #806
static Food + #223, #856
static Food + #224, #438
static Food + #225, #997
static Food + #226, #942
static Food + #227, #432
static Food + #228, #860
static Food + #229, #739
static Food + #230, #924
static Food + #231, #506
static Food + #232, #226
static Food + #233, #693
static Food + #234, #886
static Food + #235, #764
static Food + #236, #289
static Food + #237, #956
static Food + #238, #644
static Food + #239, #770
static Food + #240, #795
static Food + #241, #205
static Food + #242, #190
static Food + #243, #901
static Food + #244, #425
static Food + #245, #573
static Food + #246, #1071
static Food + #247, #698
static Food + #248, #844
static Food + #249, #423
static Food + #250, #922
static Food + #251, #926
static Food + #252, #724
static Food + #253, #344
static Food + #254, #941
static Food + #255, #824
static Food + #256, #317
static Food + #257, #419
static Food + #258, #801
static Food + #259, #252
static Food + #260, #641
static Food + #261, #509
static Food + #262, #397
static Food + #263, #223
static Food + #264, #316
static Food + #265, #472
static Food + #266, #892
static Food + #267, #1049
static Food + #268, #167
static Food + #269, #288
static Food + #270, #1089
static Food + #271, #884
static Food + #272, #862
static Food + #273, #466
static Food + #274, #890
static Food + #275, #378
static Food + #276, #995
static Food + #277, #396
static Food + #278, #1001
static Food + #279, #522
static Food + #280, #571
static Food + #281, #870
static Food + #282, #303
static Food + #283, #533
static Food + #284, #264
static Food + #285, #323
static Food + #286, #262
static Food + #287, #721
static Food + #288, #691
static Food + #289, #619
static Food + #290, #909
static Food + #291, #424
static Food + #292, #286
static Food + #293, #808
static Food + #294, #364
static Food + #295, #756
static Food + #296, #220
static Food + #297, #1081
static Food + #298, #273
static Food + #299, #758
static Food + #300, #322
static Food + #301, #415
static Food + #302, #304
static Food + #303, #1033
static Food + #304, #384
static Food + #305, #878
static Food + #306, #166
static Food + #307, #1116
static Food + #308, #1091
static Food + #309, #733
static Food + #310, #1084
static Food + #311, #952
static Food + #312, #998
static Food + #313, #306
static Food + #314, #249
static Food + #315, #1065
static Food + #316, #1103
static Food + #317, #675
static Food + #318, #514
static Food + #319, #442
static Food + #320, #966
static Food + #321, #963
static Food + #322, #526
static Food + #323, #1030
static Food + #324, #313
static Food + #325, #189
static Food + #326, #969
static Food + #327, #305
static Food + #328, #1034
static Food + #329, #430
static Food + #330, #934
static Food + #331, #652
static Food + #332, #329
static Food + #333, #173
static Food + #334, #366
static Food + #335, #496
static Food + #336, #347
static Food + #337, #561
static Food + #338, #597
static Food + #339, #855
static Food + #340, #583
static Food + #341, #702
static Food + #342, #842
static Food + #343, #1011
static Food + #344, #461
static Food + #345, #804
static Food + #346, #346
static Food + #347, #437
static Food + #348, #540
static Food + #349, #476
static Food + #350, #837
static Food + #351, #455
static Food + #352, #387
static Food + #353, #1054
static Food + #354, #676
static Food + #355, #636
static Food + #356, #1095
static Food + #357, #954
static Food + #358, #743
static Food + #359, #342
static Food + #360, #351
static Food + #361, #947
static Food + #362, #441
static Food + #363, #556
static Food + #364, #825
static Food + #365, #817
static Food + #366, #779
static Food + #367, #964
static Food + #368, #381
static Food + #369, #473
static Food + #370, #301
static Food + #371, #241
static Food + #372, #828
static Food + #373, #809
static Food + #374, #1027
static Food + #375, #263
static Food + #376, #810
static Food + #377, #925
static Food + #378, #231
static Food + #379, #867
static Food + #380, #464
static Food + #381, #731
static Food + #382, #608
static Food + #383, #255
static Food + #384, #546
static Food + #385, #734
static Food + #386, #1117
static Food + #387, #421
static Food + #388, #673
static Food + #389, #394
static Food + #390, #410
static Food + #391, #937
static Food + #392, #871
static Food + #393, #566
static Food + #394, #1111
static Food + #395, #260
static Food + #396, #689
static Food + #397, #477
static Food + #398, #356
static Food + #399, #398
static Food + #400, #609
static Food + #401, #1058
static Food + #402, #447
static Food + #403, #281
static Food + #404, #377
static Food + #405, #1070
static Food + #406, #406
static Food + #407, #781
static Food + #408, #229
static Food + #409, #492
static Food + #410, #601
static Food + #411, #988
static Food + #412, #1021
static Food + #413, #537
static Food + #414, #615
static Food + #415, #1092
static Food + #416, #467
static Food + #417, #973
static Food + #418, #843
static Food + #419, #375
static Food + #420, #711
static Food + #421, #367
static Food + #422, #933
static Food + #423, #238
static Food + #424, #697
static Food + #425, #541
static Food + #426, #1016
static Food + #427, #411
static Food + #428, #1113
static Food + #429, #272
static Food + #430, #393
static Food + #431, #202
static Food + #432, #1042
static Food + #433, #594
static Food + #434, #744
static Food + #435, #1064
static Food + #436, #581
static Food + #437, #1101
static Food + #438, #270
static Food + #439, #591
static Food + #440, #768
static Food + #441, #740
static Food + #442, #986
static Food + #443, #195
static Food + #444, #332
static Food + #445, #932
static Food + #446, #257
static Food + #447, #254
static Food + #448, #836
static Food + #449, #852
static Food + #450, #1118
static Food + #451, #783
static Food + #452, #670
static Food + #453, #502
static Food + #454, #660
static Food + #455, #246
static Food + #456, #188
static Food + #457, #418
static Food + #458, #713
static Food + #459, #1090
static Food + #460, #528
static Food + #461, #951
static Food + #462, #392
static Food + #463, #803
static Food + #464, #598
static Food + #465, #848
static Food + #466, #521
static Food + #467, #448
static Food + #468, #187
static Food + #469, #774
static Food + #470, #612
static Food + #471, #784
static Food + #472, #328
static Food + #473, #232
static Food + #474, #454
static Food + #475, #685
static Food + #476, #769
static Food + #477, #1003
static Food + #478, #978
static Food + #479, #782
static Food + #480, #980
static Food + #481, #390
static Food + #482, #475
static Food + #483, #911
static Food + #484, #887
static Food + #485, #741
static Food + #486, #443
static Food + #487, #1096
static Food + #488, #1068
static Food + #489, #266
static Food + #490, #529
static Food + #491, #338
static Food + #492, #1017
static Food + #493, #570
static Food + #494, #465
static Food + #495, #961
static Food + #496, #633
static Food + #497, #897
static Food + #498, #875
static Food + #499, #895
static Food + #500, #355
static Food + #501, #750
static Food + #502, #709
static Food + #503, #773
static Food + #504, #683
static Food + #505, #324
static Food + #506, #967
static Food + #507, #850
static Food + #508, #191
static Food + #509, #914
static Food + #510, #1106
static Food + #511, #469
static Food + #512, #403
static Food + #513, #737
static Food + #514, #664
static Food + #515, #228
static Food + #516, #757
static Food + #517, #429
static Food + #518, #687
static Food + #519, #265
static Food + #520, #893
static Food + #521, #866
static Food + #522, #268
static Food + #523, #586
static Food + #524, #549
static Food + #525, #504
static Food + #526, #791
static Food + #527, #877
static Food + #528, #562
static Food + #529, #1060
static Food + #530, #846
static Food + #531, #197
static Food + #532, #858
static Food + #533, #524
static Food + #534, #376
static Food + #535, #299
static Food + #536, #1015
static Food + #537, #775
static Food + #538, #706
static Food + #539, #1073
static Food + #540, #456
static Food + #541, #787
static Food + #542, #1035
static Food + #543, #965
static Food + #544, #408
static Food + #545, #287
static Food + #546, #330
static Food + #547, #551
static Food + #548, #617
static Food + #549, #851
static Food + #550, #827
static Food + #551, #380
static Food + #552, #900
static Food + #553, #244
static Food + #554, #352
static Food + #555, #790
static Food + #556, #602
static Food + #557, #755
static Food + #558, #716
static Food + #559, #176
static Food + #560, #284
static Food + #561, #180
static Food + #562, #1037
static Food + #563, #935
static Food + #564, #907
static Food + #565, #548
static Food + #566, #245
static Food + #567, #247
static Food + #568, #530
static Food + #569, #630
static Food + #570, #315
static Food + #571, #694
static Food + #572, #369
static Food + #573, #218
static Food + #574, #235
static Food + #575, #991
static Food + #576, #219
static Food + #577, #1007
static Food + #578, #427
static Food + #579, #939
static Food + #580, #493
static Food + #581, #474
static Food + #582, #483
static Food + #583, #236
static Food + #584, #575
static Food + #585, #503
static Food + #586, #1110
static Food + #587, #953
static Food + #588, #646
static Food + #589, #762
static Food + #590, #460
static Food + #591, #974
static Food + #592, #341
static Food + #593, #1066
static Food + #594, #667
static Food + #595, #611
static Food + #596, #703
static Food + #597, #655
static Food + #598, #230
static Food + #599, #271
static Food + #600, #930
static Food + #601, #821
static Food + #602, #692
static Food + #603, #789
static Food + #604, #1105
static Food + #605, #899
static Food + #606, #865
static Food + #607, #811
static Food + #608, #179
static Food + #609, #833
static Food + #610, #707
static Food + #611, #992
static Food + #612, #458
static Food + #613, #786
static Food + #614, #736
static Food + #615, #908
static Food + #616, #616
static Food + #617, #554
static Food + #618, #1008
static Food + #619, #576
static Food + #620, #977
static Food + #621, #1041
static Food + #622, #696
static Food + #623, #372
static Food + #624, #729
static Food + #625, #1072
static Food + #626, #669
static Food + #627, #345
static Food + #628, #912
static Food + #629, #516
static Food + #630, #335
static Food + #631, #318
static Food + #632, #1032
static Food + #633, #931
static Food + #634, #508
static Food + #635, #1024
static Food + #636, #468
static Food + #637, #767
static Food + #638, #563
static Food + #639, #637
static Food + #640, #585
static Food + #641, #761
static Food + #642, #916
static Food + #643, #666
static Food + #644, #512
static Food + #645, #820
static Food + #646, #626
static Food + #647, #1077
static Food + #648, #927
static Food + #649, #362
static Food + #650, #1031
static Food + #651, #653
static Food + #652, #1052
static Food + #653, #906
static Food + #654, #498
static Food + #655, #486
static Food + #656, #1088
static Food + #657, #835
static Food + #658, #1099
static Food + #659, #224
static Food + #660, #859
static Food + #661, #348
static Food + #662, #723
static Food + #663, #172
static Food + #664, #727
static Food + #665, #513
static Food + #666, #168
static Food + #667, #1006
static Food + #668, #416
static Food + #669, #444
static Food + #670, #982
static Food + #671, #596
static Food + #672, #777
static Food + #673, #1098
static Food + #674, #227
static Food + #675, #754
static Food + #676, #290
static Food + #677, #242
static Food + #678, #923
static Food + #679, #621
static Food + #680, #311
static Food + #681, #588
static Food + #682, #405
static Food + #683, #785
static Food + #684, #1074
static Food + #685, #374
static Food + #686, #1086
static Food + #687, #327
static Food + #688, #622
static Food + #689, #905
static Food + #690, #539
static Food + #691, #420
static Food + #692, #936
static Food + #693, #297
static Food + #694, #518
static Food + #695, #815
static Food + #696, #181
static Food + #697, #552
static Food + #698, #169
static Food + #699, #984
static Food + #700, #1022
static Food + #701, #589
static Food + #702, #491
static Food + #703, #250
static Food + #704, #237
static Food + #705, #657
static Food + #706, #631
static Food + #707, #645
static Food + #708, #274
static Food + #709, #580
static Food + #710, #682
static Food + #711, #955
static Food + #712, #823
static Food + #713, #333
static Food + #714, #413
static Food + #715, #312
static Food + #716, #849
static Food + #717, #674
static Food + #718, #192
static Food + #719, #185
static Food + #720, #1043
static Food + #721, #595
static Food + #722, #225
static Food + #723, #868
static Food + #724, #389
static Food + #725, #590
static Food + #726, #1059
static Food + #727, #650
static Food + #728, #217
static Food + #729, #629
static Food + #730, #1026
static Food + #731, #940
static Food + #732, #981
static Food + #733, #904
static Food + #734, #748
static Food + #735, #634
static Food + #736, #970
static Food + #737, #678
static Food + #738, #962
static Food + #739, #902
static Food + #740, #206
static Food + #741, #864
static Food + #742, #648
static Food + #743, #717
static Food + #744, #1085
static Food + #745, #495
static Food + #746, #353
static Food + #747, #883
static Food + #748, #417
static Food + #749, #882
static Food + #750, #198
static Food + #751, #178
static Food + #752, #1069
static Food + #753, #164
static Food + #754, #412
static Food + #755, #1075
static Food + #756, #186
static Food + #757, #863
static Food + #758, #428
static Food + #759, #358
static Food + #760, #889
static Food + #761, #944
static Food + #762, #578
static Food + #763, #778
static Food + #764, #950
static Food + #765, #309
static Food + #766, #704
static Food + #767, #545
static Food + #768, #752
static Food + #769, #1005
static Food + #770, #368
static Food + #771, #921
static Food + #772, #957
static Food + #773, #625
static Food + #774, #715
static Food + #775, #993
static Food + #776, #277
static Food + #777, #500
static Food + #778, #700
static Food + #779, #829
static Food + #780, #308
static Food + #781, #261
static Food + #782, #910
static Food + #783, #208
static Food + #784, #623
static Food + #785, #293
static Food + #786, #732
static Food + #787, #876
static Food + #788, #1114
static Food + #789, #745
static Food + #790, #404
static Food + #791, #853
static Food + #792, #497
static Food + #793, #819
static Food + #794, #1093
static Food + #795, #221
static Food + #796, #632
static Food + #797, #278
static Food + #798, #765
static Food + #799, #484
static Food + #800, #1050
static Food + #801, #170
static Food + #802, #535
static Food + #803, #813
static Food + #804, #749
static Food + #805, #171
static Food + #806, #861
static Food + #807, #647
static Food + #808, #656
static Food + #809, #385
static Food + #810, #494
static Food + #811, #1057
static Food + #812, #517
static Food + #813, #718
static Food + #814, #610
static Food + #815, #243
static Food + #816, #253
static Food + #817, #1009
static Food + #818, #162
static Food + #819, #543
static Food + #820, #690
static Food + #821, #826
static Food + #822, #445
static Food + #823, #738
static Food + #824, #184
static Food + #825, #872
static Food + #826, #505
static Food + #827, #1013
static Food + #828, #453
static Food + #829, #659
static Food + #830, #1025
static Food + #831, #574
static Food + #832, #499
static Food + #833, #538
static Food + #834, #213
static Food + #835, #1018
static Food + #836, #681
static Food + #837, #298
static Food + #838, #371
static Food + #839, #592
static Food + #840, #1045
static Food + #841, #699
static Food + #842, #373
static Food + #843, #544
static Food + #844, #812
static Food + #845, #788
static Food + #846, #285
static Food + #847, #401
static Food + #848, #553
static Food + #849, #292
static Food + #850, #482
static Food + #851, #606
static Food + #852, #209
static Food + #853, #618
static Food + #854, #793
static Food + #855, #776
static Food + #856, #307
static Food + #857, #161
static Food + #858, #635
static Food + #859, #193
static Food + #860, #334
static Food + #861, #395
static Food + #862, #662
static Food + #863, #688
static Food + #864, #446
static Food + #865, #182
static Food + #866, #971
static Food + #867, #507
static Food + #868, #203
static Food + #869, #918
static Food + #870, #1062
static Food + #871, #488
static Food + #872, #834
static Food + #873, #603
static Food + #874, #661
static Food + #875, #222
static Food + #876, #177
static Food + #877, #383
static Food + #878, #1028
static Food + #879, #888
static Food + #880, #336
static Food + #881, #672
static Food + #882, #256
static Food + #883, #470
static Food + #884, #434
static Food + #885, #558
static Food + #886, #501
static Food + #887, #1055
static Food + #888, #321
static Food + #889, #449
static Food + #890, #1112
static Food + #891, #489
static Food + #892, #722
static Food + #893, #1046
static Food + #894, #361
static Food + #895, #1076
static Food + #896, #814
static Food + #897, #527
static Food + #898, #339
static Food + #899, #296
static Food + #900, #838
static Food + #901, #903
static Food + #902, #742
static Food + #903, #1053
static Food + #904, #582
static Food + #905, #671
static Food + #906, #613
static Food + #907, #233
static Food + #908, #996
static Food + #909, #183
static Food + #910, #1115
static Food + #911, #684


; Inicialização do jogo
InitGame:
    ; Tela de menu
    MenuScreen:
        call ClearScreen       ; Limpa a tela
        loadn r1, #TelaInit0   ; Endereço da primeira linha da cena do menu
        loadn r2, #1280        ; Cor roxa
        call PrintScreen       ; Imprime a cena do menu com a cor roxa

    ; Loop do menu
    MenuLoop:
        loadn r3, #255         ; Valor padrão da tecla se nenhuma tecla for pressionada
        inchar r4              ; Entrada do teclado
        cmp r4, r3             ; Compara se a tecla enter foi pressionada
        jeq MenuLoop           ; Continua lendo até que uma tecla válida seja pressionada
        jmp StartGame          ; Se sim, inicia o jogo

    ; Tela de morte
    DeathScreen:
        call ClearScreen       ; Limpa a tela
        loadn r1, #telaFim0    ; Endereço onde a cena do menu de morte começa
        loadn r2, #2304        ; Cor vermelha
        call PrintScreen       ; Imprime a cena do menu de morte na cor vermelha
        call DisplayScoreDeathScreen      ; Exibe o score atual na tela de morte

    ; Loop da tela de morte
    DeathLoop:
        loadn r3, #255         ; Valor padrão da tecla se nenhuma tecla for pressionada
        inchar r4              ; Entrada do teclado
        cmp r4, r3             ; Compara se a tecla enter foi pressionada
        jeq MenuLoop           ; Continua lendo até que uma tecla válida seja pressionada
        jmp StartGame          ; Se sim, inicia o jogo

    ; Inicialização do jogo
    StartGame:
        call ClearScreen       ; Limpa a tela
        loadn r1, #TelaJogo0   ; Endereço da primeira linha da cena do jogo
        loadn r2, #1536        ; Cor azul claro
        call PrintScreen       ; Imprime a cena do jogo na cor azul claro
        loadn r5, #0           ; Reinicia o comprimento
        store Length, r5
        loadn r0, #700         ; Posição inicial da cobra
        store SnakePos, r0     ; Armazena a posição na variável
        dec r0
        store SnakeBody, r0    ; Posição inicial do corpo da cobra
        loadn r0, #'w'         ; Configura para mover a cobra para cima inicialmente
        store LastKey, r0      ; Armazena em LastKey para manter o movimento a cada ciclo
        call PrintFood         ; Chama a função para exibir a primeira comida no jogo
        call ResetScore        ; Reseta o score

    ; Loop principal do jogo
    GameLoop:
        call MoveSnake         ; Chama a função responsável por mover a cobra
        call DrawSnake         ; Chama a função responsável por desenhar a cobra
        call Delay             ; Chama a função responsável pelo atraso
        jmp GameLoop           ; Reinicia o loop

; Função para desenhar a cobra
DrawSnake:
    push r0                    ; Salva os valores dos registradores
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6

    loadn r1, #2648            ; Usa o caractere G para representar a cobra
    loadn r5, #' '             ; Também carrega ' ' para apagar o corpo
    load r0, SnakePos          ; Carrega a posição da cobra em R0
    loadn r2, #SnakeBody       ; Carrega o endereço da primeira posição do corpo da cobra
    loadn r4, #0               ; Carrega 0 e Length para o loop do corpo
    load r6, Length

    DrawSnakeLoop:
        loadi r3, r2           ; Carrega a posição anterior do corpo da cobra
        outchar r1, r0         ; Imprime a posição atual da cobra
        nop
        nop
        nop
        outchar r5, r3         ; Apaga a posição anterior
        loadn r1, #2639        ; Define o corpo com o caractere '0' após o primeiro loop
        storei r2, r0          ; Armazena a posição atual no vetor SnakeBody
        mov r0, r3             ; Atualiza a posição atual para a próxima iteração
        cmp r4, r6             ; Verifica se todos os segmentos da cobra foram impressos
        jeq DrawSnakeEnd       ; Se todos foram impressos, termina a rotina
        inc r4
        inc r2
        jmp DrawSnakeLoop

    DrawSnakeEnd:
        store SnakeTailPos, r3 ; Armazena a posição da cauda
        pop r6                 ; Restaura os registradores
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

; Função para verificar colisão
CheckCollision:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5

    load r0, SnakePos         ; Carrega a posição da cobra em R0
    loadn r1, #SnakeBody      ; Carrega o endereço do vetor dos corpos da cobra
    loadn r2, #0              ; Carrega 0 em R2
    load r4, Length           ; Carrega o comprimento da cobra em R4
    loadn r5, #'*'            ; Carrega '*' para paredes

    CollisionLoop:
        cmp r2, r4            ; Para i de 0 ao comprimento da cobra
        jeq CollisionEnd
        loadi r3, r1          ; Carrega a posição de cada pedaço do corpo da cobra
        cmp r0, r3            ; Compara a posição da cabeça com o pedaço do corpo
        jeq DeathScreen       ; Se igual, ocorre uma colisão e a cobra morre
        inc r2                ; Incrementa i no loop
        inc r1                ; Move para a próxima posição do pedaço do corpo
        jmp CollisionLoop

    CollisionEnd:
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

; Função para mover a cobra
MoveSnake:
    push r0
    push r1
    push r2

    call RecalculateSnakePos  ; Chama a função responsável por calcular a próxima posição da cobra
    load r0, SnakePos         ; Carrega a posição da cobra
    load r2, FoodPos          ; Carrega a posição da comida
    cmp r0, r2
    jeq IncreaseSnake         ; Se igual (comida comida), chama a função para aumentar a cobra
    call CheckCollision       ; Chama a função para verificar se houve colisão da cobra

    MoveSnake_Skip:
        pop r2
        pop r1
        pop r0
        rts

; Função para recalcular a posição da cobra
RecalculateSnakePos:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5

    load r0, SnakePos         ; Carrega a posição atual da cobra
    inchar r1                 ; Recebe a tecla pressionada

    ; Verifica se a tecla pressionada foi 'a'
    loadn r2, #'a'
    cmp r1, r2
    jeq MoveLeft
    ; Verifica se a tecla pressionada foi 'd'
    loadn r2, #'d'
    cmp r1, r2
    jeq MoveRight
    ; Verifica se a tecla pressionada foi 'w'
    loadn r2, #'w'
    cmp r1, r2
    jeq MoveUp
    ; Verifica se a tecla pressionada foi 's'
    loadn r2, #'s'
    cmp r1, r2
    jeq MoveDown

    ; Mantém o movimento na mesma direção
    loadn r2, #'a'
    load r1, LastKey
    cmp r1, r2
    jeq MoveLeft
    loadn r2, #'d'
    load r1, LastKey
    cmp r1, r2
    jeq MoveRight
    loadn r2, #'w'
    load r1, LastKey
    cmp r1, r2
    jeq MoveUp
    loadn r2, #'s'
    load r1, LastKey
    cmp r1, r2
    jeq MoveDown

    RecalculatePos_End:
        store SnakePos, r0    ; Armazena a posição da cobra
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

    ; Tratamento para movimentação para a esquerda
    MoveLeft:
        loadn r1, #40
        loadn r2, #1
        mod r1, r0, r1         ; Obtém o resto da divisão da posição da cobra por 40
        cmp r1, r2             ; Verifica se está na coluna 1 da tela (borda do cenário)
        jeq DeathScreen        ; Se sim, morte!
        load r4, LastKey
        loadn r5, #'d'
        cmp r4, r5
        jeq MoveRight
        dec r0                 ; Move uma célula para a esquerda
        loadn r3, #'a'
        store LastKey, r3
        jmp RecalculatePos_End

    ; Tratamento para movimentação para a direita
    MoveRight:
        loadn r1, #40
        loadn r2, #38
        mod r1, r0, r1         ; Obtém o resto da divisão da posição da cobra por 40
        cmp r1, r2             ; Verifica se está na coluna 38 da tela (borda do cenário)
        jeq DeathScreen        ; Se sim, morte!
        load r4, LastKey
        loadn r5, #'a'
        cmp r4, r5
        jeq MoveLeft
        inc r0                 ; Move uma célula para a direita
        loadn r3, #'d'
        store LastKey, r3
        jmp RecalculatePos_End

    ; Tratamento para movimentação para cima
    MoveUp:
        loadn r1, #160
        cmp r0, r1             ; Compara se a cobra está na linha 3 (<160)
        jle DeathScreen        ; Se sim, morte!
        load r4, LastKey
        loadn r5, #'s'
        cmp r4, r5
        jeq MoveDown
        loadn r1, #40
        sub r0, r0, r1         ; Move uma célula para cima
        loadn r3, #'w'
        store LastKey, r3
        jmp RecalculatePos_End

    ; Tratamento para movimentação para baixo
    MoveDown:
        loadn r1, #1119
        cmp r0, r1             ; Compara se a cobra está na linha 29
        jgr DeathScreen        ; Se sim, morte!
        load r4, LastKey
        loadn r5, #'w'
        cmp r4, r5
        jeq MoveUp
        loadn r1, #40
        add r0, r0, r1         ; Move uma célula para baixo
        loadn r3, #'s'
        store LastKey, r3
        jmp RecalculatePos_End

; Função para aumentar a cobra e incrementar o score
IncreaseSnake:
    push r0
    push r1
    push r2

    call PrintFood            ; Se a cobra come a comida, imprime outra
    call UpdateScore          ; Atualiza o score
    load r0, SnakeTailPos     ; Carrega a posição da cauda
    load r2, Length           ; Carrega o comprimento da cobra
    loadn r1, #SnakeBody
    inc r2                    ; Incrementa o comprimento
    add r1, r1, r2            ; Atualiza o vetor com o novo comprimento
    storei r1, r0             ; Armazena a posição da cauda na última posição do vetor
    store Length, r2          ; Armazena o comprimento da cobra

    pop r2
    pop r1
    pop r0
    jmp MoveSnake_Skip

; Função para limpar a tela
ClearScreen:
    push r0
    push r1

    loadn r0, #1200           ; Define 1200 como o número de posições para limpar na tela
    loadn r1, #' '            ; Caractere de espaço para limpar

    ClearScreenLoop:
        dec r0                ; Decrementa o contador
        outchar r1, r0        ; Imprime espaço na posição atual
        jnz ClearScreenLoop   ; Repete até que o contador chegue a zero

    pop r1
    pop r0
    rts

; Função para imprimir a tela
PrintScreen:
    push r0
    push r3
    push r4
    push r5

    loadn r0, #0              ; Posição inicial deve ser o começo da tela
    loadn r3, #40             ; Passa para a próxima linha
    loadn r4, #41             ; Incremento do ponteiro
    loadn r5, #1200           ; Limite da tela

    PrintScreenLoop:
        call PrintStr         ; Chama a função para imprimir cada pixel
        add r0, r0, r3        ; Incrementa a posição para a próxima linha na tela
        add r1, r1, r4        ; Incrementa o ponteiro para a próxima linha na memória
        cmp r0, r5            ; Verifica se o fim da tela foi alcançado
        jne PrintScreenLoop

    pop r5
    pop r4
    pop r3
    pop r0
    rts

; Função para imprimir uma string
PrintStr:
    push r0
    push r1
    push r2
    push r3
    push r4

    loadn r3, #'\0'           ; Critério de parada

    PrintStrLoop:
        loadi r4, r1          ; Obtém o primeiro caractere
        cmp r4, r3            ; Verifica o critério de parada
        jeq PrintStrExit
        add r4, r2, r4        ; Adiciona a cor
        outchar r4, r0        ; Imprime o caractere na tela
        inc r0                ; Incrementa a posição na tela
        inc r1                ; Incrementa o ponteiro da string
        jmp PrintStrLoop

    PrintStrExit:
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

; Função para imprimir a comida
PrintFood:
    push r0
    push r1
    push r2
    push r3

    loadn r1, #298            ; Caractere * marrom
    loadn r2, #Food         ; Endereço do vetor de posição da comida
    load r3, FoodIndex        ; Incremento para caminhar pelo vetor
    add r0, r2, r3            ; Calcula a posição da comida
    loadi r2, r0              ; Carrega a posição da comida na tela
    outchar r1, r2            ; Imprime a comida na posição calculada

    inc r3                    ; Incrementa o índice para a próxima comida
    store FoodIndex, r3
    store FoodPos, r2

    pop r3
    pop r2
    pop r1
    pop r0
    rts

; A função de delay foi configurada para operar com 1,200,000 ciclos totais, o que equivale a um delay de 0.1 segundo,
; considerando que a frequência de clock da máquina é de 12 MHz. Esse ajuste é específico para garantir a precisão
; temporal para simulações e operações que requerem esta configuração específica de delay.
; A prova real de cálculo: 1,200,000 ciclos / (12,000,000 ciclos/segundo) = 0.1 segundo, confirma que o delay
; está corretamente configurado para essa frequência de clock.
Delay:
    push r0
    push r1

    loadn r1, #400            ; Define o valor inicial do contador externo
    DelayLoop2:
        loadn r0, #250       ; Define o valor inicial do contador interno
    DelayLoop:
        dec r0                ; Decrementa o contador interno
        jnz DelayLoop         ; Se não zero, repete o loop interno
        dec r1                ; Decrementa o contador externo
        jnz DelayLoop2        ; Se não zero, repete o loop externo

    pop r1
    pop r0
    rts

; Função para resetar o score
ResetScore:
    loadn r0, #'0'
    store UnitScore, r0
    store TenScore, r0
    store HundredScore, r0
    call UpdateScoreDisplay
    rts

; Função para atualizar o score
UpdateScore:
    load r0, UnitScore    ; Soma um ponto na unidade
    loadn r1, #'9'           ; Se a unidade já for 9, então vai para somar na dezena
    cmp r1, r0
    jeq AddTens

    inc r0
    store UnitScore, r0
    jmp UpdateScoreDisplay

AddTens:                      ; Soma um na dezena
    loadn r0, #'0'
    store UnitScore, r0

    load r0, TenScore
    loadn r1, #'9'           ; Se a dezena já é 9, então vai somar na centena
    cmp r1, r0
    jeq AddHundreds

    inc r0
    store TenScore, r0
    jmp UpdateScoreDisplay

AddHundreds:                  ; Soma um na centena
    loadn r0, #'0'
    store TenScore, r0

    load r0, HundredScore
    loadn r1, #'9'           ; Se a centena é 9, então dá gameover
    cmp r1, r0
    jeq DeathScreen

    inc r0
    store HundredScore, r0
    jmp UpdateScoreDisplay

; Função para atualizar o display do score
UpdateScoreDisplay:
    load r0, UnitScore
    loadn r1, #78
    outchar r0, r1

    load r0, TenScore
    loadn r1, #77
    outchar r0, r1

    load r0, HundredScore
    loadn r1, #76
    outchar r0, r1

    rts

; Função para exibir o score
DisplayScoreDeathScreen:
    load r0, UnitScore
    loadn r1, #858           ; Posição para unidade na tela de morte
    outchar r0, r1

    load r0, TenScore
    loadn r1, #857           ; Posição para dezena na tela de morte
    outchar r0, r1

    load r0, HundredScore
    loadn r1, #856           ; Posição para centena na tela de morte
    outchar r0, r1

    rts

;---------------------------------- TELA DO JOGO-------------------------------------------------------	
TelaJogo0  : string "|======================================|"
TelaJogo1  : string "|                                      |"
TelaJogo0  : string "|======================================|"
TelaJogo4  : string "|                                      |"
TelaJogo5  : string "|                                      |"
TelaJogo6  : string "|                                      |"
TelaJogo3  : string "|                                      |"
TelaJogo7  : string "|                                      |"
TelaJogo8  : string "|                                      |"
TelaJogo9  : string "|                                      |"
TelaJogo10 : string "|                                      |"
TelaJogo11 : string "|                                      |"
TelaJogo12 : string "|                                      |"
TelaJogo13 : string "|                                      |"
TelaJogo14 : string "|                                      |"
TelaJogo15 : string "|                                      |"
TelaJogo16 : string "|                                      |"
TelaJogo17 : string "|                                      |"
TelaJogo18 : string "|                                      |"
TelaJogo19 : string "|                                      |"
TelaJogo20 : string "|                                      |"
TelaJogo21 : string "|                                      |"
TelaJogo22 : string "|                                      |"
TelaJogo23 : string "|                                      |"
TelaJogo24 : string "|                                      |"
TelaJogo25 : string "|                                      |"
TelaJogo26 : string "|                                      |"
TelaJogo27 : string "|                                      |"
TelaJogo28 : string "|                                      |"
TelaJogo29 : string "|======================================|"

; Tela de inicio do jogo
TelaInit0  : string "|======================================|"
TelaInit1  : string "|                                      |"
TelaInit2  : string "|                                      |"
TelaInit3  : string "|                                      |"
TelaInit4  : string "|         @@@ @@@ @@@ @ @ @@@          |"
TelaInit5  : string "|         @   @ @ @ @ @ @ @            |"
TelaInit6  : string "|         @@@ @ @ @@@ @@  @@@          |"
TelaInit7  : string "|           @ @ @ @ @ @ @ @            |"
TelaInit8  : string "|         @@@ @ @ @ @ @ @ @@@          |"
TelaInit9 : string 	"|                                      |"
TelaInit10 : string "|                                      |"
TelaInit11 : string "|         @@@ @@@ @ @ @@@              |"
TelaInit12 : string "|         @   @ @ @@@ @                |"
TelaInit13 : string "|         @@@ @@@ @@@ @@@              |"
TelaInit14 : string "|         @ @ @ @ @ @ @                |"
TelaInit15 : string "|         @@@ @ @ @ @ @@@              |"
TelaInit16 : string "|                                      |"
TelaInit17 : string "|                                      |"
TelaInit18 : string "|                                      |"
TelaInit19 : string "|                                      |"
TelaInit20 : string "|                                      |"
TelaInit21 : string "|                                      |"
TelaInit22 : string "|                                      |"
TelaInit23 : string "|                                      |"
TelaInit24 : string "|        Press any key to start        |"
TelaInit25 : string "|        _____ ___ ___ __ _____        |"
TelaInit26 : string "|                                      |"
TelaInit27 : string "|                                      |"
TelaInit28 : string "|                                      |"
TelaInit29 : string "|======================================|"

;---------------------------------- FIM DE JOGO ----------------------------------------------------------------
telaFim0  : string "|======================================|"
telaFim1  : string "|                                      |"
telaFim2  : string "|                                      |"
telaFim3  : string "|                                      |"
telaFim4  : string "|           @@@ @@@ @ @ @@@            |"
telaFim5  : string "|           @   @ @ @@@ @              |"
telaFim6  : string "|           @@@ @@@ @@@ @@@            |"
telaFim7  : string "|           @ @ @ @ @ @ @              |"
telaFim8  : string "|           @@@ @ @ @ @ @@@            |"
telaFim9  : string "|           ___ ___ ___ ___            |"
telaFim10 : string "|                                      |"
telaFim11 : string "|                                      |"
telaFim12 : string "|           @@@ @ @ @@@ @@  @          |"
telaFim13 : string "|           @ @ @ @ @   @ @ @          |"
telaFim14 : string "|           @ @ @ @ @@@ @@  @          |"
telaFim15 : string "|           @ @ @ @ @   @ @            |"
telaFim16 : string "|           @@@  @  @@@ @ @ @          |"
telaFim17 : string "|           ___ ___ ___ ___ _          |"
telaFim18 : string "|                                      |"
telaFim19 : string "|             You've scored            |"
telaFim20 : string "|                                      |"
telaFim21 : string "|                   POINTS             |"
telaFim22 : string "|                                      |"
telaFim23 : string "|                                      |"
telaFim24 : string "|                                      |"
telaFim24 : string "|        Press any key to restart      |"
telaFim25 : string "|        _____ ___ ___ __ _______      |"
telaFim26 : string "|                                      |"
telaFim28 : string "|                                      |"
telaFim29 : string "|======================================|"