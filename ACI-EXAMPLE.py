#!/usr/bin/env python

# list of packages that should be imported for this code to work
import cobra.mit.access
import cobra.mit.session
import cobra.mit.request
import cobra.model.fv
import cobra.model.pol
from cobra.internal.codec.xmlcodec import toXMLStr

# log into an APIC and create a directory object
ls = cobra.mit.session.LoginSession('https://192.168.10.1', 'admin', 'NXos12345')
md = cobra.mit.access.MoDirectory(ls)
md.login()

# the top level object on which operations will be made
topMo = cobra.model.pol.Uni('')


# build the request using cobra syntax
fvTenant = cobra.model.fv.Tenant(topMo, ownerKey='', name='MIA-REST', descr='', ownerTag='')
fvCtx = cobra.model.fv.Ctx(fvTenant, ownerKey='', name='MIA-REST-VRF', descr='', knwMcastAct='permit', ownerTag='', pcEnfPref='enforced')
fvBD = cobra.model.fv.BD(fvTenant, ownerKey='', name='MIA-REST-BD', descr='', unkMacUcastAct='proxy', arpFlood='no', mac='00:22:BD:F8:19:FF', unicastRoute='yes', ownerTag='', unkMcastAct='flood')
fvRsCtx = cobra.model.fv.RsCtx(fvBD, tnFvCtxName='MIA-REST-VRF')
fvSubnet = cobra.model.fv.Subnet(fvBD, ctrl='', name='', descr='', ip='172.17.115.254/24', scope = 'public')
fvRsBdToEpRet = cobra.model.fv.RsBdToEpRet(fvBD, resolveAct='resolve', tnFvEpRetPolName='')

# commit the generated code to APIC
#print toXMLStr(topMo)
##c = cobra.mit.request.ConfigRequest()
#c.addMo(topMo)
#md.commit(c)
