#ifndef MOD_PERL_H
#define MOD_PERL_H

#define PERL_NO_GET_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/*XXX*/
#undef TRUE
#undef FALSE

#include "ap_mmn.h"
#include "httpd.h"
#include "http_config.h"
#include "http_log.h"
#include "http_protocol.h"

#include "apr_lock.h"

module MODULE_VAR_EXPORT perl_module;

#include "modperl_flags.h"
#include "modperl_hooks.h"

#include "modperl_types.h"
#include "modperl_config.h"
#include "modperl_callback.h"
#include "modperl_interp.h"
#include "modperl_log.h"

#include "modperl_directives.h"

#endif /*  MOD_PERL_H */
