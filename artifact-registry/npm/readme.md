### 1. Infra Setup

### 2. Local Setup and config

a) npm config get registry => https://registry.npmjs.org/

b) npm config set registry https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/

c) npm config get registry => https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo

d) verify .npmrc file is generated in HOME directory

e) Generate and set token in .npmrc
npm set //asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/:_authToken=$(gcloud auth print-access-token)

- verify .npmrc => cat ~/.npmrc
```
cat ~/.npmrc
registry=https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo
//asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo:_authToken=ya29.a0AeDClZAE4WGtr_jdzjiqDoSX1F3D5yVRAo4TzHwEAoI2lgHwj0Z7ExLmrNXc8FINrWUBKJB24wQC51YVkRjCQiaUSNDBACOROOqh-sTOm0S9KCnePtFS1FQLtxbTJtNXGRULck6dYLkYL6qA96G5apaCVvoGxuxykq4ALQEpY_qnR9AaCgYKAUMSARISFQHGX2MiSpFZlBMHPLwAy5Sm6W7evQ0182
```

### 4. Test Connectivity

To confirm that your network or firewall settings are not blocking access, try:
```
curl -I -H "Authorization: Bearer $(gcloud auth print-access-token)" https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/pdf-viewer
```
If you still get a 403 Forbidden, the issue is likely with IAM permissions or your .npmrc setup.


### 5. Install libraries

- find . -type d -name "pdf-viewer"
- npm cache clean --force
- npm install pdf-viewer -v

### 6. CURL and WGET commands to download libraries from repo


https://asia-south1-npm.pkg.dev/devops-438202/npm-mirror-repo


https://asia-south1-npm.pkg.dev/devops-438202/npm-mirror-repo/emoji-regex/10.4.0/emoji-regex-10.4.0.tgz

```
wget --header="Authorization: Bearer $(gcloud auth print-access-token)" \
  https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/pdf-viewer/-/pdf-viewer-0.8.1.tgz


fyi:  pdf-viewer/-/pdf-viewer-0.8.1.tgz  => works  |  pdf-viewer/0.81/pdf-viewer-0.8.1.tgz  => Not works



wget --header "Authorization: Bearer $(gcloud auth print-access-token)" \
https://asia-south1-npm.pkg.dev/devops-438202/npm-mirror-repo/emoji-regex/-/emoji-regex-10.4.0.tgz
```



### Need to use -L as there is many redirecct happens, without -L the file is not downloaded
```
curl -L -v -o emoji-regex.tgz -H "Authorization: Bearer $(gcloud auth print-access-token)" -o emoji-regex-10.4.0.tgz https://asia-south1-npm.pkg.dev/devops-438202/npm-mirror-repo/emoji-regex/-/emoji-regex-10.4.0.tgz


curl -L -o emoji-regex-demo.tgz -H "Authorization: Bearer $(gcloud auth print-access-token)" -o emoji-regex-10.4.0.tgz https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/emoji-regex/-/emoji-regex-10.4.0.tgz
```




### Appendinx success logs
```
 npm install csv-parse --verbose
npm verb cli /usr/bin/node /usr/bin/npm
npm info using npm@8.19.4
npm info using node@v16.20.2
npm timing npm:load:whichnode Completed in 0ms
npm timing config:load:defaults Completed in 2ms
npm timing config:load:file:/usr/lib/node_modules/npm/npmrc Completed in 0ms
npm timing config:load:builtin Completed in 1ms
npm timing config:load:cli Completed in 2ms
npm timing config:load:env Completed in 0ms
npm timing config:load:file:/home/nantha/DEVSECOPS/gcp-devsecops/artifact-repo/npm/app/node-demo/.npmrc Completed in 0ms
npm timing config:load:project Completed in 11ms
npm timing config:load:file:/home/nantha/.npmrc Completed in 2ms
npm timing config:load:user Completed in 2ms
npm timing config:load:file:/usr/etc/npmrc Completed in 0ms
npm timing config:load:global Completed in 0ms
npm timing config:load:validate Completed in 2ms
npm timing config:load:credentials Completed in 1ms
npm timing config:load:setEnvs Completed in 1ms
npm timing config:load Completed in 22ms
npm timing npm:load:configload Completed in 22ms
npm timing npm:load:mkdirpcache Completed in 1ms
npm timing npm:load:mkdirplogs Completed in 0ms
npm verb title npm install csv-parse
npm verb argv "install" "csv-parse" "--loglevel" "verbose"
npm timing npm:load:setTitle Completed in 1ms
npm timing config:load:flatten Completed in 2ms
npm timing npm:load:display Completed in 8ms
npm verb logfile logs-max:10 dir:/home/nantha/.npm/_logs
npm verb logfile /home/nantha/.npm/_logs/2024-12-04T21_05_13_691Z-debug-0.log
npm timing npm:load:logFile Completed in 7ms
npm timing npm:load:timers Completed in 0ms
npm timing npm:load:configScope Completed in 0ms
npm timing npm:load Completed in 42ms
npm timing arborist:ctor Completed in 1ms
npm timing idealTree:init Completed in 19ms
npm timing idealTree:userRequests Completed in 2ms
npm timing arborist:ctor Completed in 0ms
npm http fetch GET 200 https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/csv-parse 1624ms (cache miss)
npm timing idealTree:#root Completed in 1638ms
npm timing idealTree:node_modules/csv-parse Completed in 0ms
npm timing idealTree:buildDeps Completed in 1639ms
npm timing idealTree:fixDepFlags Completed in 0ms
npm timing idealTree Completed in 1663ms
npm timing reify:loadTrees Completed in 1664ms
npm timing reify:diffTrees Completed in 1ms
npm timing reify:retireShallow Completed in 1ms
npm timing reify:createSparse Completed in 3ms
npm timing reify:loadBundles Completed in 0ms
npm notice operation is not supported.
npm http fetch POST 404 https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/-/npm/v1/security/advisories/bulk 111ms
npm notice operation is not supported.
npm http fetch POST 404 https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/-/npm/v1/security/audits/quick 321ms
npm verb audit error HttpErrorGeneral: 404 Not Found - POST https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/-/npm/v1/security/audits/quick - operation is not supported.
npm verb audit error     at /usr/lib/node_modules/npm/node_modules/npm-registry-fetch/lib/check-response.js:95:15
npm verb audit error     at processTicksAndRejections (node:internal/process/task_queues:96:5)
npm verb audit error     at async Map.[getReport] (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/audit-report.js:335:21)
npm verb audit error     at async Map.run (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/audit-report.js:106:19)
npm verb audit error  HttpErrorGeneral: 404 Not Found - POST https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/-/npm/v1/security/audits/quick - operation is not supported.
npm verb audit error     at /usr/lib/node_modules/npm/node_modules/npm-registry-fetch/lib/check-response.js:95:15
npm verb audit error     at processTicksAndRejections (node:internal/process/task_queues:96:5)
npm verb audit error     at async Map.[getReport] (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/audit-report.js:335:21)
npm verb audit error     at async Map.run (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/audit-report.js:106:19) {
npm verb audit error   headers: [Object: null prototype] {
npm verb audit error     'content-type': [ 'application/json; charset=utf-8' ],
npm verb audit error     'npm-notice': [ 'operation is not supported.' ],
npm verb audit error     'x-content-type-options': [ 'nosniff' ],
npm verb audit error     'x-frame-options': [ 'SAMEORIGIN' ],
npm verb audit error     'x-xss-protection': [ '0' ],
npm verb audit error     date: [ 'Wed, 04 Dec 2024 21:05:15 GMT' ],
npm verb audit error     'content-length': [ '40' ],
npm verb audit error     'alt-svc': [ 'h3=":443"; ma=2592000,h3-29=":443"; ma=2592000' ],
npm verb audit error     'x-fetch-attempts': [ '1' ]
npm verb audit error   },
npm verb audit error   statusCode: 404,
npm verb audit error   code: 'E404',
npm verb audit error   method: 'POST',
npm verb audit error   uri: 'https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/-/npm/v1/security/audits/quick',
npm verb audit error   body: { error: 'operation is not supported.' },
npm verb audit error   pkgid: 'quick'
npm verb audit error }
npm timing auditReport:getReport Completed in 460ms
npm timing reify:audit Completed in 462ms
npm http fetch GET 200 https://asia-south1-npm.pkg.dev/artifacts-downloads/namespaces/devops-438202/repositories/npm-virtual-repo/downloads/ADZxxkgkrEdQwC4dv6-ZMKe1rsnFAU4Fn3g4FIYUKFPwqLjK3hkAfHs0ddJw-VTgVndvi35VJvpqzHFd389EAH0sOXvKjEXIaZhKwGi1Lr3PXAilGLgw81GKjeFcg35_M9CGDOjTnV15qF3lPzH9CCeiu1OI0yntM_FeLiY28G1VvEYnlg8a16ywyO3Nyr83bQdbDUJ10EXT-h58Oz-jVI48heyf_H1GjeQTlFioMNLkcR8lH7sf7slf-TQOwxDm9EPktWfhEdlnyjVcDDAlQw54rOI9EIgch82X980ZU0d6DeQ1vp-Rm2TFiI1krMMMrINj7p-fEcesGbbELPKTWq15w2TEA828sSGMogbWUzWhqPcxMOBv9d9HTZPRDvmzMawOi2Q7tsQ4divBIj56vT3fYw4-K3CaOOZfQRwQzPasxlBiRc_921cHZYJotSJ0tsbDL0Biu5HvJ9S_LU4Jn4nLjO6_Uy101yDXmHY9JRAjF4dC61bgGkVLiy4Q9bcQA2z7lcothDDq47bWWjj_rvsuWnQcgFdNNz6NnvWM2Qwiyah7DW4PHZ3U54I-xyv4ZZrFZp0KDyczBdxl4QvuJrHNh5dJTiKgEeEgH6a_-2bgy7qmlWeaqxj9RPb9WKQtAP5uFcpnSJz7gajLkWZMcxCisuZJAC2KksREYbhIXz-2328yV47jpWmXRDS7zwtXAT_H88Diylb2Vua4rLeWI9M4AylrtcmRZEgfRj8G5PiagfdTQZHtD_kT8Ru__71hbCVNi27rpDxrLMLhEBG1ynXmJ0XjZFVIJtHskeLUUTUlToJORYEtNSDyPfQ6P7Tf54gdVcP6zj3rNm5UmhzZP3b5Cxz18b-yHhiGP7K61kL50FVlBWjbzUPqr6XxCIwpioUjiytVk6Sp_5QLYf0DWZLgupJC_mu_mNgQOmPjL3OtNCJaqtMoLvx1NdRCqzJd8HvoH933Pp9yvHqrpJl1kYQy6kr7FIULpszjDxiqUoFn0MQK2Fbp-_kHZuSxCkwvwTK4YE5SUvPrqHWuQYpqTgiC77kPky8hNOBGFYqtL7sAA1cc_e8nqjQrobdgwaVM1oPvvxAWMIqcdqeZMARG5KGzlAqjLWbqeFsR9HjxNwvpiTJrEKSQlhrtkw0ZNo2ADE4w6IsHKP8mvb797zjsZf47WDjLhbtCxnbpKtXlmZX74zXqzZ60awA0T77bBfVi_YUoOvFmSHuZmvm9U4JY4sJo8V24QB2pRQgcVSD5gD0JzU9OK2tJP3dpE1m8RrAsCDpOqVOkshgsF1r696Fjj3aTxKF4qNNbJ2L6FK7U4jsxxAAP6MxzOtrqgkXetclT1d7O1k2YEr0HzmkJuEAoJPCEYIi7l-Vcd71SeMPC-A1vRWlde3atyxGnblZgRjXCJJlnCse5pEN7wSrWXrPcwPrCKgd_EEwg5eoJ_4xhXsqsy27WguuX0uyFWa56IM3aKDUvmUcVUoO_b05qVSeWI42c42sTH-unPhkhiqLgtD0rRd9xIp4kD9UtJ90QEFckAbE-ISKu0jVphJAmAs_GI8ncEC1I-XM2k9Vkba30oqSIsnkXUI-LedgEisdG3QOPMjovp14p98yyrVs4Yn3rlDEmNezT_IozXnaoSOnLr__KwWF-b0mPv3fkCezxkDW7MGXmFmnw_mJCJEBzdqv6Mo5GIu8JQJJ0a5zWOT1rUzOsO_0Al05GmaIPEoXF9JfVGWtTGYSjq4haZNwX43uxCqM6cVlE1deBQ71ntDAfSnTv6R81CwQEP9-N8Oaw46d6F8cyKws7B-YF7D_LI1JM_zVNUTzJCfTRLlO681Sk15v7b7SaNF3Da4P44wy8kKfxe9n4cHvTlgcx-2bue8g35NBl8V0dU-15WRoqWEzhrSVB0OSyHaacWHM0Jjs0imY-9CJjJKlYLYQCdH1F-MHHcR92Kv3RG83jQstK2KAkVO6mMIRNa0TPSFwlZW4OVsqL19IWzWNnkExCcbjWsiIR5LE3K5orYt54-X9CFm7v-Rve8d4OWADqy0XAP19RoAT6qcEu_-SkxnaIIHU6FiRbF_Gu3rlsH-xlyBDaq-_pq5fkraF4FG7eY1wyjumdSCNKmmBWSOIIMAbwZhygDAgGSqEPsQ_rFrmO-QvMbtDDj0ehgYsOswZadIrqXA9F42DCGFqwBZTVyXWEOzP0fQnkaTtqCv7dTJOui1C9GpC0cYGWVhDHGnkxsJm2dP6oNk2mL7nY_1mfWqXOvmFlCZ12YCxjVcnUhmZ-jP1MZhvG2RE37udPJxJefBFokpptpER6QRqjafJHXpi44GOgtQWHAOAF87LJz2CGz4XNSIoXyf_T_oO9W8GayGsAYH89zyf7JC4zX2BE5CuRw4BtUrk5j1SDWS89oggHasbLaltdyfV369ncVeoq7ItjeG_omWuHk5_egbwNGGak1cYfa7lPkEOrR5rSS1nkvoP8HRiQi2ckLu0HLqmT6rMA5eb5-CuFO__27L5jFFRhsORdH-__Zi3qfHQMNMLE7H9EzHTEtXt-RVjJHvdl8r-ezuGO2LbaqY5PwYE_h0NWJ3XuaMF_nR6zFHWAkkcNhlWXHPBnO72a8HJXsTCbJHRx2gW6YOf5FnfJzsa3QjClIiN_Hjukjaf_IH4Huvkl-Uda1D41LO60VQku_3HEmSy_UVgowy16dsB1JAvt3AFg35A_73zmI7ZuRnx7iX2VBul9eAFBw2RbwLjXbkegiiXIFp_bCIBQN9CRS3yyhdDZOynK3rT2kpWrwU3gqHcZTgzF-IwT5kSgAOB-DoOZ0ug7msqb1zKd-VQlLNEV8YM0sKGfVK0AAmvpvppnQH-CHS-ruv6dCHIm2TSSKdY7LOmVeTQMZhM65DxOinRTL7uIx-jYevB8iZbVRO5WTc9D8mxKhMu1ppNBQJW70AP83RilK5xqCjpxWqtQDm6dLmCnB_Ge3F6VHGhoczo864xU8-KtmEnDVt24h7CGnk1pkWCakc2iVNDAGV1x6Uq5Xc1Dy9Nz_ahCPYKek98cOcrv_9y7Rj7TrHtz0EMxN2tqqPjlmfCyFP8-p-JF9C3n_9mK5QhamLprt8i8KBcmD37NYU4TWu9c1oM5S6nf6ny5jNARNTOBsTizmG5026u4IuKQf5ZHcYnKQCSDUm3NxrdKmx-jVB7MfJPALhE8Mxf4hFanuDRq0ltQxzpVyPqQ1Fhgk2sjS0FyJWMu6Ca2X4ecfBDjfzpeu5yzFSAuDqs7ma1WA3gRz97kzrfD31k_3EFAI3C5t_p9ffyWCNbS4Jcu8GRUWabWWrptYBFC-C8ICVYbFwpBT5rqU292nmcFfD8BmgGNpoA0ZfIRu7q_4YGkXBWi7VpLFgbjJnXkIas3OcIWvMcQzGCqqTuH9bccvSJ4SGiElnO0oAJiTKbeQiVnHtai_Tb00avCxDdrpK5Fwlhqk2ZU48q_8FzsJadZaWZI64712KG-K1ZlK45m5ECbIRiCchkIO1kf-ewKIsOGee-IQpBy3Lw7BdzF29pPZy-pbfeIzi0vSFlf-zgM_7nW5znm32j7dqYWJlIlNNaz9R9GqnPeDMRpQD6CNUNubPCSkvioMcs2yBcMUMRNlx_5XIIAMp5deJaUWXRdZpNyjLdR5zVfimLoNxujpg_kCf1pPFsQpsPHKf4mtQq6hoUXgIWRX49KeiZ2MWlIO3oAs44_MdeOnLtYtVa7uhtTHKuGvSM9FIJsCWzv3EB7M-5QyhP0r4P85KUeJ0uY6Tppd3PMtpF2HnX4Q1YhVygaM0GXTMheF8WuaKeFPQeuBJ3X5HVfBL_H9sgfW-nqMtDEeJouP2D0lYIli40a1LYwGklYHewD0DjY9mLieVBeZAYFtwfdUNYodJL4C4AFIFzn3H1qanY0KV_l0fkgpKjakgon73-yfiYKHZRuinKse_Z4AWC8w5ErkGARMG0cvaMbeBQQVh4eBMOeuWdvy79ar4AtDlJOwIzs1DIn2Gz57Aiw9G4OFjMMyMlUds07QqGfSSMG0UnGAY8jrXH9RS8GffsB4OQEVq-RoXEpbkSQXjE-v4CH_oPlUM-NqhKzGNHE_rhc_8EluTjundB7y2izEzBuR1z4Vh3CQeMU-M3A_Tsi_I2wKCvm-FErXRqFBX_ILSJMVG8SXjeIVpriz_i5gc579U0OjBBUh1E0u3unQC-PPHitN2oEcPgxC21T7dY88shYA5-OQ2LXvdkOH9YzYucZgOqdXriKVtGSpOmTJDjZoBCI5hDbwEHNd0cPvIqKLxTiEBYbBoVOtKyJxzsiPaJrFdG5dkO-PIeOvYYDeo53QlorhjAEmWKANgCU-D9TodHzU7zJMOKpWJ5mRR4plfjq7v6eGNfZF_M17UEZbJRs1JygVfCiB-VH_hUVLSvfofvCPSXNk54fkP0n3URzmaREPIwoc3ql9iHfaKga7nOupe4RnI0b_Tb2Wvme0ppOlL8yJzWYeS-rwQAWz7Of8vwMHTcFoRwmo7XXY1OSyBmCPg5V8tKuaJvKUObN-ZUSmgmiM5II5WnHKGbSiARxOErXmbbA9ZnBwAgmBxwp 2053ms (cache miss)
npm timing reifyNode:node_modules/csv-parse Completed in 2064ms
npm timing reify:unpack Completed in 2064ms
npm timing reify:unretire Completed in 0ms
npm timing build:queue Completed in 1ms
npm timing build:deps Completed in 1ms
npm timing build Completed in 1ms
npm timing reify:build Completed in 1ms
npm timing reify:trash Completed in 0ms
npm timing reify:save Completed in 7ms
npm timing reify Completed in 3762ms

added 1 package in 4s
npm timing command:install Completed in 3767ms
npm verb exit 0
npm timing npm Completed in 3907ms
npm info ok
```


### Appendix - Trying to install Invalid Library
```
 npm install emoi-regex --verbose
npm verb cli /usr/bin/node /usr/bin/npm
npm info using npm@8.19.4
npm info using node@v16.20.2
npm timing npm:load:whichnode Completed in 0ms
npm timing config:load:defaults Completed in 4ms
npm timing config:load:file:/usr/lib/node_modules/npm/npmrc Completed in 1ms
npm timing config:load:builtin Completed in 1ms
npm timing config:load:cli Completed in 2ms
npm timing config:load:env Completed in 0ms
npm timing config:load:file:/home/nantha/DEVSECOPS/gcp-devsecops/artifact-repo/npm/app/node-demo/.npmrc Completed in 0ms
npm timing config:load:project Completed in 10ms
npm timing config:load:file:/home/nantha/.npmrc Completed in 2ms
npm timing config:load:user Completed in 2ms
npm timing config:load:file:/usr/etc/npmrc Completed in 0ms
npm timing config:load:global Completed in 0ms
npm timing config:load:validate Completed in 1ms
npm timing config:load:credentials Completed in 0ms
npm timing config:load:setEnvs Completed in 1ms
npm timing config:load Completed in 22ms
npm timing npm:load:configload Completed in 22ms
npm timing npm:load:mkdirpcache Completed in 1ms
npm timing npm:load:mkdirplogs Completed in 1ms
npm verb title npm install emoi-regex
npm verb argv "install" "emoi-regex" "--loglevel" "verbose"
npm timing npm:load:setTitle Completed in 1ms
npm timing config:load:flatten Completed in 3ms
npm timing npm:load:display Completed in 10ms
npm verb logfile logs-max:10 dir:/home/nantha/.npm/_logs
npm verb logfile /home/nantha/.npm/_logs/2024-12-04T21_01_37_464Z-debug-0.log
npm timing npm:load:logFile Completed in 6ms
npm timing npm:load:timers Completed in 0ms
npm timing npm:load:configScope Completed in 0ms
npm timing npm:load Completed in 42ms
npm timing arborist:ctor Completed in 1ms
npm timing idealTree:init Completed in 15ms
npm timing idealTree:userRequests Completed in 2ms
npm timing arborist:ctor Completed in 0ms
npm http fetch GET 404 https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/emoi-regex 1834ms (cache skip)
npm http fetch GET 404 https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/emoi-regex 1198ms (cache skip)
npm timing idealTree:#root Completed in 3055ms
npm timing idealTree:node_modules/emoi-regex Completed in 1ms
npm timing idealTree:buildDeps Completed in 3060ms
npm timing idealTree:fixDepFlags Completed in 2ms
npm timing idealTree Completed in 3083ms
npm timing command:install Completed in 3095ms
npm verb stack HttpErrorGeneral: 404 Not Found - GET https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/emoi-regex - Requested entity was not found.
npm verb stack     at /usr/lib/node_modules/npm/node_modules/npm-registry-fetch/lib/check-response.js:95:15
npm verb stack     at processTicksAndRejections (node:internal/process/task_queues:96:5)
npm verb stack     at async RegistryFetcher.packument (/usr/lib/node_modules/npm/node_modules/pacote/lib/registry.js:92:19)
npm verb stack     at async RegistryFetcher.manifest (/usr/lib/node_modules/npm/node_modules/pacote/lib/registry.js:124:23)
npm verb stack     at async Arborist.[nodeFromEdge] (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/arborist/build-ideal-tree.js:1061:19)
npm verb stack     at async Arborist.[buildDepStep] (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/arborist/build-ideal-tree.js:930:11)
npm verb stack     at async Arborist.buildIdealTree (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/arborist/build-ideal-tree.js:211:7)
npm verb stack     at async Promise.all (index 1)
npm verb stack     at async Arborist.reify (/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/arborist/reify.js:154:5)
npm verb stack     at async Install.exec (/usr/lib/node_modules/npm/lib/commands/install.js:145:5)
npm verb statusCode 404
npm verb pkgid emoi-regex@*
npm verb cwd /home/nantha/DEVSECOPS/gcp-devsecops/artifact-repo/npm/app/node-demo
npm verb Linux 5.4.0-150-generic
npm verb node v16.20.2
npm verb npm  v8.19.4
npm ERR! code E404
npm ERR! 404 Not Found - GET https://asia-south1-npm.pkg.dev/devops-438202/npm-virtual-repo/emoi-regex - Requested entity was not found.
npm ERR! 404 
npm ERR! 404  'emoi-regex@*' is not in this registry.
npm ERR! 404 
npm ERR! 404 Note that you can also install from a
npm ERR! 404 tarball, folder, http url, or git url.
npm verb exit 1
npm timing npm Completed in 3274ms
npm verb unfinished npm timer reify 1733346097630
npm verb unfinished npm timer reify:loadTrees 1733346097638
npm verb code 1

npm ERR! A complete log of this run can be found in:
npm ERR!     /home/nantha/.npm/_logs/2024-12-04T21_01_37_464Z-debug-0.log
```