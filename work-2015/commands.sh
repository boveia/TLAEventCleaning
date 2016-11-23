
# full reco on bytestream, end of 2015 data

nohup Reco_tf.py --AMITag=f628 --inputBSFile /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-1._0001.data --skipEvents 55 --maxEvents 5 --outputESDFile esd.pool.root --conditionsTag "CONDBR2-BLKPA-2015-14" --geometryVersion "ATLAS-R2-2015-03-01-00" --preExec 'DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)' &

nohup Reco_tf.py --AMITag=f628 --inputBSFile ../r00278912_multiple_events.RAW.data --outputESDFile esd.pool.root --conditionsTag "CONDBR2-BLKPA-2015-14" --geometryVersion "ATLAS-R2-2015-03-01-00" --preExec 'DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)' &


# run TLA partial reco, 2015 data

nohup Reco_tf.py --AMI=r7370 --inputBSFile ../r00278912_multiple_events.RAW.data --outputESDFile esd.pool.root --conditionsTag "CONDBR2-BLKPA-2015-14" --geometryVersion "ATLAS-R2-2015-03-01-00" --preExec 'DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)' &

nohup Reco_tf.py --AMI=r7370 --inputBSFile ../data15_13TeV.00281385.calibration_DataScouting_05_Jets.merge.RAW.o10._lb0005._0001.1 --outputESDFile esd.pool.root --conditionsTag "CONDBR2-BLKPA-2015-14" --geometryVersion "ATLAS-R2-2015-03-01-00" --preExec 'DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)' --maxEvents 10 &

# extracting events (event picking) based on run and event numbers (with input files already located)

ExtractEvents.py --inputfile /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-1._0001.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-1._0002.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-2._0001.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-2._0002.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-3._0001.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-3._0002.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-4._0001.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-4._0002.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-5._0001.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-5._0002.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-6._0001.data /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-6._0002.data --outputfile skimmed -r 278912 -lb 0144 -e 28337655,28337374,28336684,28336520,28337110,28337053,28336858,28336823,28337084,28337064


