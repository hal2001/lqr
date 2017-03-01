#ifndef LQR_CDEFS_H_
#define LQR_CDEFS_H_


#define MIN(a,b) ((a)<(b)?(a):(b))
#define MAX(a,b) ((a)>(b)?(a):(b))

#define THROW_MEMERR error("unable to allocate necessary memory")
#define CHECKMALLOC(ptr) if (ptr == NULL) THROW_MEMERR

#define THROW_LAPACKERR(info) error("LAPACK returned error code %d", info)
#define CHECKINFO(info) if (info!=0) THROW_MEMERR(info)

#define FREE(ptr) if(ptr!=NULL) free(ptr)


#endif
