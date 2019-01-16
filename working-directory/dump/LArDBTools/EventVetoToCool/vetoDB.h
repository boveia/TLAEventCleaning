#ifndef VETODB_H
#define VETODB_H

#include <CoolApplication/DatabaseSvcFactory.h>
#include <CoolKernel/IDatabaseSvc.h>
#include <CoolKernel/IDatabase.h>
#include <CoolKernel/IFolder.h>
#include <CoolKernel/IObject.h>
#include <CoralBase/Attribute.h>
#include <CoolKernel/Record.h>
#include <CoolKernel/FolderSpecification.h>
#include <CoolKernel/ValidityKey.h>

#include "stdint.h"
#include <iostream>

#include "noiseVetoStructs.h"

extern int s_verbose;

class VetoDB {
public:
  VetoDB() = delete;
  VetoDB(const VetoDB&) = delete;
  VetoDB(const std::string& dbName, const std::string& folder, const std::string& EStagName, const std::string& BKtagName, bool create=false);
  ~VetoDB();

  bool open();
  void close();

  bool store(std::vector<VetoRange_t>& vetoRanges); //returns false if the opening of the db fails. The vetoRanges might be modified (purging of duplicates)

  bool isOk() {return m_dbOk;}

  void purgeRecentRanges(const uint64_t ignoreOlderThan);
  
  bool storeToSqlite(const std::vector<VetoRange_t>& vetoRanges, const std::string& sqlitelocation) const; 

  std::vector<VetoRange_t> handleOverlaps(const std::vector<VetoRange_t>& ranges_std, const std::vector<VetoRange_t>& ranges_mnb, const std::vector<VetoRange_t>& ranges_cc) const;

private:

  std::vector<VetoRange_t> handleOverlaps2(const std::vector<VetoRange_t>& ranges1, const std::vector<VetoRange_t>& ranges2) const;
  void purgeDuplicateRanges(std::vector<VetoRange_t>& inputRanges) const;
  int updateStatus(uint8_t & status1 , uint8_t & status2 , TimeStamps TS) const;

  std::vector<VetoRange_t> mergevetoperiods(const std::vector<TimeStamps>& vector ) const ;
  std::vector<TimeStamps> buildTSvector(const std::vector<VetoRange_t>& ranges1, const std::vector<VetoRange_t>& ranges2) const ;

  std::string m_dbName;
  std::string m_fdName;
  std::string m_ESTagName; //Supposed to be UPD1 protected
  std::string m_BKTagName; //Supposed to be UPD4 protected
  cool::IDatabasePtr m_db;
  cool::RecordSpecification m_spec;

  bool m_dbOk;
  bool m_create;
 
  std::vector<VetoRange_t> m_recentRanges;

};

struct orderingbytime {
  bool operator() (TimeStamps i ,TimeStamps j){ return (i.timeStamp < j.timeStamp); }

};
#endif  
