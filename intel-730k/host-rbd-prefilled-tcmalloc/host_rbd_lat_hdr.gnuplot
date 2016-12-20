set terminal png size 1280, 720
set output 'host_rbd_lat_hdr.png'
set logscale x
unset xtics
set key top left
set title 'host rbd 4KB randwrite, prefilled image, OSDs: tcmalloc'
set xlabel 'Percentile'
set ylabel 'Latency, msec'
plot \
	'-' using 4:1 with lines notitle, \
	'-' with labels center offset 0, 0.5 point notitle
       Value     Percentile TotalCount 1/(1-Percentile)

       0.650 0.000000000000          1           1.00
       1.788 0.100000000000    3151546           1.11
       1.958 0.190000000000    5988965           1.23
       2.077 0.271000000000    8529844           1.37
       2.175 0.343900000000   10830692           1.52
       2.263 0.409510000000   12923181           1.69
       2.345 0.468559000000   14755976           1.88
       2.431 0.521703100000   16427848           2.09
       2.527 0.569532790000   17936040           2.32
       2.641 0.612579511000   19278729           2.58
       2.785 0.651321559900   20496789           2.87
       2.951 0.686189403910   21587607           3.19
       3.119 0.717570463519   22582500           3.54
       3.273 0.745813417167   23466352           3.93
       3.415 0.771232075450   24265568           4.37
       3.547 0.794108867905   24983217           4.86
       3.673 0.814697981115   25636874           5.40
       3.791 0.833228183003   26211716           6.00
       3.909 0.849905364703   26738133           6.66
       4.027 0.864914828233   27213416           7.40
       4.151 0.878423345409   27645551           8.23
       4.279 0.890581010868   28023850           9.14
       4.419 0.901522909782   28366841          10.15
       4.575 0.911370618803   28672185          11.28
       4.755 0.920233556923   28948442          12.54
       4.963 0.928210201231   29199392          13.93
       5.203 0.935389181108   29424923          15.48
       5.487 0.941850262997   29628554          17.20
       5.815 0.947665236697   29812716          19.11
       6.171 0.952898713028   29976577          21.23
       6.575 0.957608841725   30124084          23.59
       7.003 0.961847957552   30257727          26.21
       7.439 0.965663161797   30377158          29.12
       7.883 0.969096845617   30485760          32.36
       8.327 0.972187161056   30583834          35.95
       8.767 0.974968444950   30670097          39.95
       9.223 0.977471600455   30749504          44.39
       9.687 0.979724440410   30819529          49.32
      10.191 0.981751996369   30883806          54.80
      10.735 0.983576796732   30941343          60.89
      11.303 0.985219117059   30992701          67.65
      11.903 0.986697205353   31038812          75.17
      12.527 0.988027484817   31080843          83.52
      13.143 0.989224736336   31118382          92.81
      13.759 0.990302262702   31152466         103.12
      14.391 0.991272036432   31182831         114.57
      15.023 0.992144832789   31210301         127.30
      15.703 0.992930349510   31235010         141.45
      16.415 0.993637314559   31257359         157.17
      17.199 0.994273583103   31277238         174.63
      17.999 0.994846224793   31295459         194.03
      18.799 0.995361602313   31311493         215.59
      19.583 0.995825442082   31325989         239.55
      20.319 0.996242897874   31339240         266.16
      20.991 0.996618608086   31350928         295.74
      21.631 0.996956747278   31361778         328.60
      22.223 0.997261072550   31371155         365.11
      22.783 0.997534965295   31379744         405.67
      23.327 0.997781468766   31387659         450.75
      23.823 0.998003321889   31394512         500.83
      24.303 0.998202989700   31400921         556.48
      24.751 0.998382690730   31406431         618.31
      25.167 0.998544421657   31411539         687.01
      25.599 0.998689979491   31416176         763.35
      26.031 0.998820981542   31420354         848.16
      26.415 0.998938883388   31424059         942.40
      26.799 0.999044995049   31427357        1047.11
      27.199 0.999140495544   31430341        1163.46
      27.599 0.999226445990   31433004        1292.73
      27.999 0.999303801391   31435401        1436.37
      28.431 0.999373421252   31437601        1595.97
      28.879 0.999436079127   31439551        1773.30
      29.359 0.999492471214   31441344        1970.33
      29.871 0.999543224093   31442933        2189.26
      30.527 0.999588901683   31444348        2432.51
      31.247 0.999630011515   31445648        2702.79
      32.351 0.999667010363   31446810        3003.10
      33.663 0.999700309327   31447880        3336.77
      35.935 0.999730278394   31448799        3707.53
      39.711 0.999757250555   31449647        4119.47
      46.399 0.999781525499   31450411        4577.19
     208.511 0.999803372950   31451097        5085.77
     228.095 0.999823035655   31451721        5650.86
     237.055 0.999840732089   31452290        6278.73
     243.071 0.999856658880   31452772        6976.37
     248.447 0.999870992992   31453231        7751.52
     253.695 0.999883893693   31453642        8612.80
     257.407 0.999895504324   31454016        9569.77
     259.839 0.999905953891   31454329       10633.08
     262.015 0.999915358502   31454644       11814.54
     264.191 0.999923822652   31454902       13127.26
     266.495 0.999931440387   31455128       14585.85
     269.055 0.999938296348   31455375       16206.50
     270.335 0.999944466713   31455535       18007.22
     271.871 0.999950020042   31455709       20008.02
     273.407 0.999955018038   31455875       22231.13
     274.943 0.999959516234   31456035       24701.26
     276.479 0.999963564611   31456150       27445.84
     278.783 0.999967208150   31456250       30495.38
     280.319 0.999970487335   31456353       33883.76
     282.623 0.999973438601   31456459       37648.62
     284.927 0.999976094741   31456536       41831.80
     286.207 0.999978485267   31456608       46479.78
     288.255 0.999980636740   31456675       51644.20
     291.327 0.999982573066   31456737       57382.44
     293.119 0.999984315760   31456787       63758.27
     296.703 0.999985884184   31456836       70842.52
     299.775 0.999987295765   31456889       78713.91
     301.055 0.999988566189   31456928       87459.90
     303.359 0.999989709570   31456959       97177.67
     305.919 0.999990738613   31456989      107975.19
     314.879 0.999991664752   31457022      119972.43
     317.951 0.999992498276   31457048      133302.70
     319.999 0.999993248449   31457077      148114.11
     321.535 0.999993923604   31457091      164571.23
     325.119 0.999994531244   31457110      182856.93
     329.727 0.999995078119   31457127      203174.36
     331.775 0.999995570307   31457145      225749.29
     332.799 0.999996013277   31457156      250832.55
     334.591 0.999996411949   31457168      278702.83
     334.847 0.999996770754   31457179      309669.81
     337.663 0.999997093679   31457190      344077.57
     339.455 0.999997384311   31457200      382308.41
     342.527 0.999997645880   31457213      424787.12
     342.783 0.999997881292   31457216      471985.69
     343.295 0.999998093163   31457223      524428.54
     345.087 0.999998283846   31457229      582698.38
     345.343 0.999998455462   31457237      647442.64
     345.343 0.999998609915   31457237      719380.72
     347.135 0.999998748924   31457243      799311.91
     351.487 0.999998874032   31457247      888124.34
     359.167 0.999998986628   31457256      986804.82
     359.167 0.999999087966   31457256     1096449.80
     359.167 0.999999179169   31457256     1218277.56
     371.967 0.999999261252   31457260     1353641.73
     371.967 0.999999335127   31457260     1504046.37
     372.223 0.999999401614   31457262     1671162.63
     376.063 0.999999461453   31457264     1856847.37
     384.511 0.999999515307   31457269     2063163.74
     384.511 0.999999563777   31457269     2292404.16
     384.511 0.999999607399   31457269     2547115.73
     384.511 0.999999646659   31457269     2830128.59
     390.655 0.999999681993   31457273     3144587.32
     390.655 0.999999713794   31457273     3493985.91
     390.655 0.999999742415   31457273     3882206.57
     390.655 0.999999768173   31457273     4313562.86
     393.215 0.999999791356   31457277     4792847.62
     393.215 0.999999812220   31457277     5325386.25
     393.215 0.999999830998   31457277     5917095.83
     393.215 0.999999847898   31457277     6574550.92
     393.215 0.999999863109   31457277     7305056.58
     393.215 0.999999876798   31457277     8116729.54
     393.215 0.999999889118   31457277     9018588.37
     393.215 0.999999900206   31457277    10020653.74
     401.919 0.999999910186   31457280    11134059.72
     401.919 1.000000000000   31457280
#[Mean    =        3.085, StdDeviation   =     4295.616]
#[Max     =      401.919, TotalCount     = 31457280.000]
#[Buckets =           22, SubBuckets     =         2048]
e
1 0.0 0%
10 0.0 90%
100 0.0 99%
1000 0.0 99.9%
10000 0.0 99.99%
100000 0.0 99.999%
1000000 0.0 99.9999%
e