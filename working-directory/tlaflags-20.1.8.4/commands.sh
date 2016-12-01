nohup Reco_tf.py --AMITag=f628 --inputBSFile /tmp/boveia/data15_13TeV.00278912.physics_Main.daq.RAW._lb0144._SFO-1._0001.data --outputESDFile esd.pool.root --conditionsTag "CONDBR2-BLKPA-2015-14" --geometryVersion "ATLAS-R2-2015-03-01-00" --preExec 'DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)'  &

#preExec="InDetFlags.useBeamConstraint.set_Value_and_Lock(False)"

#preExec='DQMonFlags.doCTPMon=False;from MuonRecExample.MuonRecFlags import muonRecFlags;muonRecFlags.useLooseErrorTuning.set_Value_and_Lock(True);jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25);InDetFlags.InDet25nsec.set_Value_and_Lock(True); InDetFlags.useBeamConstraint.set_Value_and_Lock(False)'


#{'conditionsTag': {'all': 'CONDBR2-BLKPA-2015-14'}, 'ignorePatterns': ['ToolSvc.InDetSCTRodDecoder.+ERROR.+Unknown.+offlineId.+for.+OnlineId'], 'ignoreErrors': True, 'autoConfiguration': ['everything'], 'maxEvents': '-1', 'AMITag': 'f628', 'postExec': {'e2d': ['from AthenaCommon.AppMgr import ServiceMgr; import MuonRPC_Cabling.MuonRPC_CablingConfig ; ServiceMgr.MuonRPC_CablingSvc.RPCMapfromCool=False ; ServiceMgr.MuonRPC_CablingSvc.CorrFileName="LVL1confAtlasRUN2_ver016.corr"; ServiceMgr.MuonRPC_CablingSvc.ConfFileName="LVL1confAtlasRUN2_ver016.data" ']}, 'preExec': {'all': ['from MuonRecExample.MuonRecFlags import muonRecFlags;muonRecFlags.useLooseErrorTuning.set_Value_and_Lock(True);DQMonFlags.doCTPMon=False;jobproperties.Beam.bunchSpacing.set_Value_and_Lock(25)']}, 'geometryVersion': {'all': 'ATLAS-R2-2015-03-01-00'}}

