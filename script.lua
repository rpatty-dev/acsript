aci_copyright=[[




ACI 0.2
Uses code by PG23186706924 and Anavrins, see following copyright notice:

SHA-256, HMAC and PBKDF2 functions in ComputerCraft
By Anavrins
For help and details, you can PM me on the CC forums
You may use this code in your projects without asking me, as long as credit is given and this header is kept intact
http://www.computercraft.info/forums2/index.php?/user/12870-anavrins
http://pastebin.com/6UV4qfNF
Last update: October 10, 2017
]]local a={__tostring=function(b)return string.char(unpack(b))end,__index={toHex=function(self)return("%02x"):rep(#self):format(unpack(self))end,isEqual=function(self,c)if type(c)~="table"then return false end;if#self~=#c then return false end;local d=0;for e=1,#self do d=bit.bor(d,bit.bxor(self[e],c[e]))end;return d==0 end} }local f=(function()local g=2^32;local h=bit.band;local i=bit.bnot;local j=bit.bxor;local k=bit.lshift;local l=unpack;local function m(n,o)local p=n/2^o;local q=p%1;return p-q+q*g end;local function r(s,t)local p=s/2^t;return p-p%1 end;local u={0x6a09e667,0xbb67ae85,0x3c6ef372,0xa54ff53a,0x510e527f,0x9b05688c,0x1f83d9ab,0x5be0cd19}local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)local y,z=0,0;if 0xFFFFFFFF-y<x then z=z+1;y=x-(0xFFFFFFFF-y)-1 else y=y+x end;return z,y end;local function A(B,e)return k(B[e]or 0,24)+k(B[e+1]or 0,16)+k(B[e+2]or 0,8)+(B[e+3]or 0)end;local function C(D)local E=#D;local F={}D[#D+1]=0x80;while#D%64~=56 do D[#D+1]=0 end;local G=math.ceil(#D/64)for e=1,G do F[e]={}for H=1,16 do F[e][H]=A(D,1+(e-1)*64+(H-1)*4)end end;F[G][15],F[G][16]=w(E*8)return F end;local function I(J,K)for H=17,64 do local L=j(j(m(J[H-15],7),m(J[H-15],18)),r(J[H-15],3))local M=j(j(m(J[H-2],17),m(J[H-2],19)),r(J[H-2],10))J[H]=(J[H-16]+L+J[H-7]+M)%g end;local b,o,N,O,P,q,Q,R=l(K)for H=1,64 do local S=j(j(m(P,6),m(P,11)),m(P,25))local T=j(h(P,q),h(i(P),Q))local U=(R+S+T+v[H]+J[H])%g;local V=j(j(m(b,2),m(b,13)),m(b,22))local W=j(j(h(b,o),h(b,N)),h(o,N))local X=(V+W)%g;R,Q,q,P,O,N,o,b=Q,q,P,(O+U)%g,N,o,b,(U+X)%g end;K[1]=(K[1]+b)%g;K[2]=(K[2]+o)%g;K[3]=(K[3]+N)%g;K[4]=(K[4]+O)%g;K[5]=(K[5]+P)%g;K[6]=(K[6]+q)%g;K[7]=(K[7]+Q)%g;K[8]=(K[8]+R)%g;return K end;local function Y(c,n)local o={}for e=1,n do o[(e-1)*4+1]=h(r(c[e],24),0xFF)o[(e-1)*4+2]=h(r(c[e],16),0xFF)o[(e-1)*4+3]=h(r(c[e],8),0xFF)o[(e-1)*4+4]=h(c[e],0xFF)end;return setmetatable(o,a)end;local function Z(D)D=D or""D=type(D)=="table"and{l(D)}or{tostring(D):byte(1,-1)}D=C(D)local K={l(u)}for e=1,#D do K=I(D[e],K)end;return Y(K,8)end;local function _(D,a0)local D=type(D)=="table"and{l(D)}or{tostring(D):byte(1,-1)}local a0=type(a0)=="table"and{l(a0)}or{tostring(a0):byte(1,-1)}local a1=64;a0=#a0>a1 and Z(a0)or a0;local a2={}local a3={}local a4={}for e=1,a1 do a2[e]=j(0x36,a0[e]or 0)a3[e]=j(0x5C,a0[e]or 0)end;for e=1,#D do a2[a1+e]=D[e]end;a2=Z(a2)for e=1,a1 do a4[e]=a3[e]a4[a1+e]=a2[e]end;return Z(a4)end;local function a5(a6,a7,a8,a9)local a7=type(a7)=="table"and a7 or{tostring(a7):byte(1,-1)}local aa=32;local a9=a9 or 32;local ab=1;local ad={}while a9>0 do local ae={}local af={l(a7)}local ag=a9>aa and aa or a9;af[#af+1]=h(r(ab,24),0xFF)af[#af+1]=h(r(ab,16),0xFF)af[#af+1]=h(r(ab,8),0xFF)af[#af+1]=h(ab,0xFF)for H=1,a8 do af=_(af,a6)for ah=1,ag do ae[ah]=j(af[ah],ae[ah]or 0)end;if H%200==0 then os.queueEvent("PBKDF2",H)coroutine.yield("PBKDF2")end end;a9=a9-ag;ab=ab+1;for ah=1,ag do ad[#ad+1]=ae[ah]end end;return setmetatable(ad,a)end;return{digest=Z,hmac=_,pbkdf2=a5}end)()local ai=(function()local function aj(b,o)return b[1]==o[1]and b[2]==o[2]and b[3]==o[3]and b[4]==o[4]and b[5]==o[5]and b[6]==o[6]and b[7]==o[7]end;local function ak(b,o)for e=7,1,-1 do if b[e]>o[e]then return 1 elseif b[e]<o[e]then return-1 end end;return 0 end;local function al(b,o)local am=b[1]+o[1]local an=b[2]+o[2]local ao=b[3]+o[3]local ap=b[4]+o[4]local aq=b[5]+o[5]local ar=b[6]+o[6]local as=b[7]+o[7]if am>0xffffff then an=an+1;am=am-0x1000000 end;if an>0xffffff then ao=ao+1;an=an-0x1000000 end;if ao>0xffffff then ap=ap+1;ao=ao-0x1000000 end;if ap>0xffffff then aq=aq+1;ap=ap-0x1000000 end;if aq>0xffffff then ar=ar+1;aq=aq-0x1000000 end;if ar>0xffffff then as=as+1;ar=ar-0x1000000 end;return{am,an,ao,ap,aq,ar,as}end;local function at(b,o)local am=b[1]-o[1]local an=b[2]-o[2]local ao=b[3]-o[3]local ap=b[4]-o[4]local aq=b[5]-o[5]local ar=b[6]-o[6]local as=b[7]-o[7]if am<0 then an=an-1;am=am+0x1000000 end;if an<0 then ao=ao-1;an=an+0x1000000 end;if ao<0 then ap=ap-1;ao=ao+0x1000000 end;if ap<0 then aq=aq-1;ap=ap+0x1000000 end;if aq<0 then ar=ar-1;aq=aq+0x1000000 end;if ar<0 then as=as-1;ar=ar+0x1000000 end;return{am,an,ao,ap,aq,ar,as}end;local function au(b)local am=b[1]local an=b[2]local ao=b[3]local ap=b[4]local aq=b[5]local ar=b[6]local as=b[7]am=am/2;am=am-am%1;am=am+an%2*0x800000;an=an/2;an=an-an%1;an=an+ao%2*0x800000;ao=ao/2;ao=ao-ao%1;ao=ao+ap%2*0x800000;ap=ap/2;ap=ap-ap%1;ap=ap+aq%2*0x800000;aq=aq/2;aq=aq-aq%1;aq=aq+ar%2*0x800000;ar=ar/2;ar=ar-ar%1;ar=ar+as%2*0x800000;as=as/2;as=as-as%1;return{am,an,ao,ap,aq,ar,as}end;local function av(b,o)local am=b[1]+o[1]local an=b[2]+o[2]local ao=b[3]+o[3]local ap=b[4]+o[4]local aq=b[5]+o[5]local ar=b[6]+o[6]local as=b[7]+o[7]local aw=b[8]+o[8]local ax=b[9]+o[9]local ay=b[10]+o[10]local az=b[11]+o[11]local aA=b[12]+o[12]local aB=b[13]+o[13]local aC=b[14]+o[14]if am>0xffffff then an=an+1;am=am-0x1000000 end;if an>0xffffff then ao=ao+1;an=an-0x1000000 end;if ao>0xffffff then ap=ap+1;ao=ao-0x1000000 end;if ap>0xffffff then aq=aq+1;ap=ap-0x1000000 end;if aq>0xffffff then ar=ar+1;aq=aq-0x1000000 end;if ar>0xffffff then as=as+1;ar=ar-0x1000000 end;if as>0xffffff then aw=aw+1;as=as-0x1000000 end;if aw>0xffffff then ax=ax+1;aw=aw-0x1000000 end;if ax>0xffffff then ay=ay+1;ax=ax-0x1000000 end;if ay>0xffffff then az=az+1;ay=ay-0x1000000 end;if az>0xffffff then aA=aA+1;az=az-0x1000000 end;if aA>0xffffff then aB=aB+1;aA=aA-0x1000000 end;if aB>0xffffff then aC=aC+1;aB=aB-0x1000000 end;return{am,an,ao,ap,aq,ar,as,aw,ax,ay,az,aA,aB,aC}end;local function aD(b,o,aE)local aF,aG,aH,aI,aJ,aK,aL=unpack(b)local aM,aN,aO,aP,aQ,aR,aS=unpack(o)local am=aF*aM;local an=aF*aN+aG*aM;local ao=aF*aO+aG*aN+aH*aM;local ap=aF*aP+aG*aO+aH*aN+aI*aM;local aq=aF*aQ+aG*aP+aH*aO+aI*aN+aJ*aM;local ar=aF*aR+aG*aQ+aH*aP+aI*aO+aJ*aN+aK*aM;local as=aF*aS+aG*aR+aH*aQ+aI*aP+aJ*aO+aK*aN+aL*aM;local aw,ax,ay,az,aA,aB,aC;if not aE then aw=aG*aS+aH*aR+aI*aQ+aJ*aP+aK*aO+aL*aN;ax=aH*aS+aI*aR+aJ*aQ+aK*aP+aL*aO;ay=aI*aS+aJ*aR+aK*aQ+aL*aP;az=aJ*aS+aK*aR+aL*aQ;aA=aK*aS+aL*aR;aB=aL*aS;aC=0 else aw=0 end;local aT;aT=am;am=am%0x1000000;an=an+(aT-am)/0x1000000;aT=an;an=an%0x1000000;ao=ao+(aT-an)/0x1000000;aT=ao;ao=ao%0x1000000;ap=ap+(aT-ao)/0x1000000;aT=ap;ap=ap%0x1000000;aq=aq+(aT-ap)/0x1000000;aT=aq;aq=aq%0x1000000;ar=ar+(aT-aq)/0x1000000;aT=ar;ar=ar%0x1000000;as=as+(aT-ar)/0x1000000;aT=as;as=as%0x1000000;if not aE then aw=aw+(aT-as)/0x1000000;aT=aw;aw=aw%0x1000000;ax=ax+(aT-aw)/0x1000000;aT=ax;ax=ax%0x1000000;ay=ay+(aT-ax)/0x1000000;aT=ay;ay=ay%0x1000000;az=az+(aT-ay)/0x1000000;aT=az;az=az%0x1000000;aA=aA+(aT-az)/0x1000000;aT=aA;aA=aA%0x1000000;aB=aB+(aT-aA)/0x1000000;aT=aB;aB=aB%0x1000000;aC=aC+(aT-aB)/0x1000000 end;return{am,an,ao,ap,aq,ar,as,aw,ax,ay,az,aA,aB,aC}end;local function aU(b)local aF,aG,aH,aI,aJ,aK,aL=unpack(b)local am=aF*aF;local an=aF*aG*2;local ao=aF*aH*2+aG*aG;local ap=aF*aI*2+aG*aH*2;local aq=aF*aJ*2+aG*aI*2+aH*aH;local ar=aF*aK*2+aG*aJ*2+aH*aI*2;local as=aF*aL*2+aG*aK*2+aH*aJ*2+aI*aI;local aw=aG*aL*2+aH*aK*2+aI*aJ*2;local ax=aH*aL*2+aI*aK*2+aJ*aJ;local ay=aI*aL*2+aJ*aK*2;local az=aJ*aL*2+aK*aK;local aA=aK*aL*2;local aB=aL*aL;local aC=0;local aT;aT=am;am=am%0x1000000;an=an+(aT-am)/0x1000000;aT=an;an=an%0x1000000;ao=ao+(aT-an)/0x1000000;aT=ao;ao=ao%0x1000000;ap=ap+(aT-ao)/0x1000000;aT=ap;ap=ap%0x1000000;aq=aq+(aT-ap)/0x1000000;aT=aq;aq=aq%0x1000000;ar=ar+(aT-aq)/0x1000000;aT=ar;ar=ar%0x1000000;as=as+(aT-ar)/0x1000000;aT=as;as=as%0x1000000;aw=aw+(aT-as)/0x1000000;aT=aw;aw=aw%0x1000000;ax=ax+(aT-aw)/0x1000000;aT=ax;ax=ax%0x1000000;ay=ay+(aT-ax)/0x1000000;aT=ay;ay=ay%0x1000000;az=az+(aT-ay)/0x1000000;aT=az;az=az%0x1000000;aA=aA+(aT-az)/0x1000000;aT=aA;aA=aA%0x1000000;aB=aB+(aT-aA)/0x1000000;aT=aB;aB=aB%0x1000000;aC=aC+(aT-aB)/0x1000000;return{am,an,ao,ap,aq,ar,as,aw,ax,ay,az,aA,aB,aC}end;local function aV(b)local aW={}for e=1,7 do local aX=b[e]for H=1,3 do aW[#aW+1]=aX%256;aX=math.floor(aX/256)end end;return aW end;local function aY(aW)local b={}local aZ={}for e=1,21 do local a_=aW[e]assert(type(a_)=="number","integer decoding failure")assert(a_>=0 and a_<=255,"integer decoding failure")assert(a_%1==0,"integer decoding failure")aZ[e]=a_ end;for e=1,21,3 do local aX=0;for H=2,0,-1 do aX=aX*256;aX=aX+aZ[e+H]end;b[#b+1]=aX end;return b end;local function b0(O,J)local b1=O[1]%2^J;if b1>=2^(J-1)then b1=b1-2^J end;return b1 end;local function b2(O,J)local c={}local O={unpack(O)}for e=1,168 do if O[1]%2==1 then c[#c+1]=b0(O,J)O=at(O,{c[#c],0,0,0,0,0,0})else c[#c+1]=0 end;O=au(O)end;return c end;return{isEqual=aj,compare=ak,add=al,sub=at,addDouble=av,mult=aD,square=aU,encodeInt=aV,decodeInt=aY,NAF=b2}end)()local b3=(function()local al=ai.add;local at=ai.sub;local av=ai.addDouble;local aD=ai.mult;local aU=ai.square;local b4={3,0,0,0,0,0,15761408}local b5={5592405,5592405,5592405,5592405,5592405,5592405,14800213}local b6={13533400,837116,6278376,13533388,837116,6278376,7504076}local function b7(b)local aF,aG,aH,aI,aJ,aK,aL=unpack(b)local am=aF*3;local an=aG*3;local ao=aH*3;local ap=aI*3;local aq=aJ*3;local ar=aK*3;local as=aF*15761408;as=as+aL*3;local aw=aG*15761408;local ax=aH*15761408;local ay=aI*15761408;local az=aJ*15761408;local aA=aK*15761408;local aB=aL*15761408;local aC=0;local aT;aT=am/0x1000000;an=an+aT-aT%1;am=am%0x1000000;aT=an/0x1000000;ao=ao+aT-aT%1;an=an%0x1000000;aT=ao/0x1000000;ap=ap+aT-aT%1;ao=ao%0x1000000;aT=ap/0x1000000;aq=aq+aT-aT%1;ap=ap%0x1000000;aT=aq/0x1000000;ar=ar+aT-aT%1;aq=aq%0x1000000;aT=ar/0x1000000;as=as+aT-aT%1;ar=ar%0x1000000;aT=as/0x1000000;aw=aw+aT-aT%1;as=as%0x1000000;aT=aw/0x1000000;ax=ax+aT-aT%1;aw=aw%0x1000000;aT=ax/0x1000000;ay=ay+aT-aT%1;ax=ax%0x1000000;aT=ay/0x1000000;az=az+aT-aT%1;ay=ay%0x1000000;aT=az/0x1000000;aA=aA+aT-aT%1;az=az%0x1000000;aT=aA/0x1000000;aB=aB+aT-aT%1;aA=aA%0x1000000;aT=aB/0x1000000;aC=aC+aT-aT%1;aB=aB%0x1000000;return{am,an,ao,ap,aq,ar,as,aw,ax,ay,az,aA,aB,aC}end;local function b8(b)if b[7]<15761408 or b[7]==15761408 and b[1]<3 then return{unpack(b)}end;local am=b[1]local an=b[2]local ao=b[3]local ap=b[4]local aq=b[5]local ar=b[6]local as=b[7]am=am-3;as=as-15761408;if am<0 then an=an-1;am=am+0x1000000 end;if an<0 then ao=ao-1;an=an+0x1000000 end;if ao<0 then ap=ap-1;ao=ao+0x1000000 end;if ap<0 then aq=aq-1;ap=ap+0x1000000 end;if aq<0 then ar=ar-1;aq=aq+0x1000000 end;if ar<0 then as=as-1;ar=ar+0x1000000 end;return{am,an,ao,ap,aq,ar,as}end;local function b9(b,o)return b8(al(b,o))end;local function ba(b,o)local b1=at(b,o)if b1[7]<0 then b1=al(b1,b4)end;return b1 end;local function bb(bc)local bd=aD(bc,b5,true)local c={unpack(av(bc,b7(bd)),8,14)}return b8(c)end;local function be(b,o)return bb(aD(b,o))end;local function bf(b)return bb(aU(b))end;local function bg(b)return be(b,b6)end;local function bh(b)local b={unpack(b)}for e=8,14 do b[e]=0 end;return bb(b)end;local bi=bg({1,0,0,0,0,0,0})local function bj(bk,bl)local bk={unpack(bk)}local b1={unpack(bi)}for e=1,168 do if bl[e]==1 then b1=be(b1,bk)end;bk=bf(bk)end;return b1 end;return{addModP=b9,subModP=ba,multModP=be,squareModP=bf,montgomeryModP=bg,inverseMontgomeryModP=bh,expModP=bj}end)()local bm=(function()local aj=ai.isEqual;local ak=ai.compare;local al=ai.add;local at=ai.sub;local av=ai.addDouble;local aD=ai.mult;local aU=ai.square;local aV=ai.encodeInt;local aY=ai.decodeInt;local bn;local bo={9622359,6699217,13940450,16775734,16777215,16777215,3940351}local bp={1,0,1,0,1,0,1,0,1,1,0,0,1,0,1,1,0,1,0,0,1,0,0,1,1,0,0,0,1,0,1,1,0,0,0,1,1,1,0,0,0,1,1,0,0,1,1,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,0,0,1,0,1,0,1,1,0,1,1,0,1,1,0,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1}local bq={15218585,5740955,3271338,9903997,9067368,7173545,6988392}local b6={1336213,11071705,9716828,11083885,9188643,1494868,3306114}local function br(b)local b1={unpack(b)}if ak(b1,bo)>=0 then b1=at(b1,bo)end;return setmetatable(b1,bn)end;local function bs(b,o)return br(al(b,o))end;local function bt(b,o)local b1=at(b,o)if b1[7]<0 then b1=al(b1,bo)end;return setmetatable(b1,bn)end;local function bb(bc)local bd={unpack(aD({unpack(bc,1,7)},bq,true),1,7)}local c={unpack(av(bc,aD(bd,bo)),8,14)}return br(c)end;local function bu(b,o)return bb(aD(b,o))end;local function bv(b)return bb(aU(b))end;local function bw(b)return bu(b,b6)end;local function bx(b)local b={unpack(b)}for e=8,14 do b[e]=0 end;return bb(b)end;local bi=bw({1,0,0,0,0,0,0})local function by(bk,bl)local bk={unpack(bk)}local b1={unpack(bi)}for e=1,168 do if bl[e]==1 then b1=bu(b1,bk)end;bk=bv(bk)end;return b1 end;local function bz(bk,bA)local bk={unpack(bk)}local b1=setmetatable({unpack(bi)},bn)if bA<0 then bk=by(bk,bp)bA=-bA end;while bA>0 do if bA%2==1 then b1=bu(b1,bk)end;bk=bv(bk)bA=bA/2;bA=bA-bA%1 end;return b1 end;local function bB(b)local b1=aV(b)return setmetatable(b1,a)end;local function bC(p)p=type(p)=="table"and{unpack(p,1,21)}or{tostring(p):byte(1,21)}local b1=aY(p)b1[7]=b1[7]%bo[7]return setmetatable(b1,bn)end;local function bD()while true do local p={unpack(random.random(),1,21)}local b1=aY(p)if b1[7]<bo[7]then return setmetatable(b1,bn)end end end;local function bE(D)return bC(f.digest(D))end;bn={__index={encode=function(self)return bB(self)end},__tostring=function(self)return self:encode():toHex()end,__add=function(self,bF)if type(self)=="number"then return bF+self end;if type(bF)=="number"then assert(bF<2^24,"number operand too big")bF=bw({bF,0,0,0,0,0,0})end;return bs(self,bF)end,__sub=function(b,o)if type(b)=="number"then assert(b<2^24,"number operand too big")b=bw({b,0,0,0,0,0,0})end;if type(o)=="number"then assert(o<2^24,"number operand too big")o=bw({o,0,0,0,0,0,0})end;return bt(b,o)end,__unm=function(self)return bt(bo,self)end,__eq=function(self,bF)return aj(self,bF)end,__mul=function(self,bF)if type(self)=="number"then return bF*self end;if type(bF)=="table"and type(bF[1])=="table"then return bF*self end;if type(bF)=="number"then assert(bF<2^24,"number operand too big")bF=bw({bF,0,0,0,0,0,0})end;return bu(self,bF)end,__div=function(b,o)if type(b)=="number"then assert(b<2^24,"number operand too big")b=bw({b,0,0,0,0,0,0})end;if type(o)=="number"then assert(o<2^24,"number operand too big")o=bw({o,0,0,0,0,0,0})end;local bG=by(o,bp)return bu(b,bG)end,__pow=function(self,bF)return bz(self,bF)end}return{hashModQ=bE,randomModQ=bD,decodeModQ=bC,inverseMontgomeryModQ=bx}end)()local bH=(function()local aj=ai.isEqual;local b2=ai.NAF;local aV=ai.encodeInt;local aY=ai.decodeInt;local be=b3.multModP;local bf=b3.squareModP;local b9=b3.addModP;local ba=b3.subModP;local bg=b3.montgomeryModP;local bj=b3.expModP;local bx=bm.inverseMontgomeryModQ;local bI;local bJ={0,0,0,0,0,0,0}local bi=bg({1,0,0,0,0,0,0})local O=bg({122,0,0,0,0,0,0})local b4={3,0,0,0,0,0,15761408}local bK={1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1}local bL={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1}local bM={ {6636044,10381432,15741790,2914241,5785600,264923,4550291},{13512827,8449886,5647959,1135556,5489843,7177356,8002203},{unpack(bi)} }local bN={ {unpack(bJ)},{unpack(bi)},{unpack(bi)} }local function bO(bP)local bQ,bR,bS=unpack(bP)local o=b9(bQ,bR)local bT=bf(o)local K=bf(bQ)local bU=bf(bR)local bV=b9(K,bU)local u=bf(bS)local bW=ba(bV,b9(u,u))local bX=be(ba(bT,bV),bW)local bY=be(bV,ba(K,bU))local bZ=be(bV,bW)local b_={bX,bY,bZ}return setmetatable(b_,bI)end;local function c0(bP,c1)local bQ,bR,bS=unpack(bP)local c2,c3,c4=unpack(c1)local c5=be(bS,c4)local bT=bf(c5)local K=be(bQ,c2)local bU=be(bR,c3)local bV=be(O,be(K,bU))local c6=ba(bT,bV)local bM=b9(bT,bV)local bX=be(c5,be(c6,ba(be(b9(bQ,bR),b9(c2,c3)),b9(K,bU))))local bY=be(c5,be(bM,ba(bU,K)))local bZ=be(c6,bM)local b_={bX,bY,bZ}return setmetatable(b_,bI)end;local function c7(bP)local bQ,bR,bS=unpack(bP)local bX=ba(bJ,bQ)local bY={unpack(bR)}local bZ={unpack(bS)}local b_={bX,bY,bZ}return setmetatable(b_,bI)end;local function c8(bP,c1)return c0(bP,c7(c1))end;local function c9(bP)local bQ,bR,bS=unpack(bP)local c5=bj(bS,bK)local bX=be(bQ,c5)local bY=be(bR,c5)local bZ={unpack(bi)}local b_={bX,bY,bZ}return setmetatable(b_,bI)end;local function ca(bP,c1)local bQ,bR,bS=unpack(bP)local c2,c3,c4=unpack(c1)local cb=be(bQ,c4)local cc=be(bR,c4)local cd=be(c2,bS)local ce=be(c3,bS)return aj(cb,cd)and aj(cc,ce)end;local function cf(bP)local bQ,bR,bS=unpack(bP)local cg=bf(bQ)local ch=bf(bR)local ci=bf(bS)local cj=bf(ci)local b=b9(cg,ch)b=be(b,ci)local o=be(O,be(cg,ch))o=b9(cj,o)return aj(b,o)end;local function ck(bP)return aj(bP[1],bJ)end;local function cl(cm,bP)local cn=b2(cm,5)local co={bP}local c1=bO(bP)local cp={ {unpack(bJ)},{unpack(bi)},{unpack(bi)} }for e=3,31,2 do co[e]=c0(co[e-2],c1)end;for e=#cn,1,-1 do cp=bO(cp)if cn[e]>0 then cp=c0(cp,co[cn[e]])elseif cn[e]<0 then cp=c8(cp,co[-cn[e]])end end;return setmetatable(cp,bI)end;local cq={bM}for e=2,168 do cq[e]=bO(cq[e-1])end;local function cr(cm)local cn=b2(cm,2)local cp={ {unpack(bJ)},{unpack(bi)},{unpack(bi)} }for e=1,168 do if cn[e]==1 then cp=c0(cp,cq[e])elseif cn[e]==-1 then cp=c8(cp,cq[e])end end;return setmetatable(cp,bI)end;local function cs(bP)bP=c9(bP)local b1={}local ct,cu=unpack(bP)b1=aV(cu)b1[22]=ct[1]%2;return setmetatable(b1,a)end;local function cv(aW)aW=type(aW)=="table"and{unpack(aW,1,22)}or{tostring(aW):byte(1,22)}local cu=aY(aW)cu[7]=cu[7]%b4[7]local cw=bf(cu)local cx=ba(cw,bi)local cy=ba(be(O,cw),bi)local cz=bf(cx)local cA=be(cx,cz)local cB=be(cA,cz)local cC=be(cy,bf(cy))local J=be(cB,cC)local ct=be(cA,be(cy,bj(J,bL)))if ct[1]%2~=aW[22]then ct=ba(bJ,ct)end;local b_={ct,cu,{unpack(bi)} }return setmetatable(b_,bI)end;bI={__index={isOnCurve=function(self)return cf(self)end,isInf=function(self)return self:isOnCurve()and ck(self)end,encode=function(self)return cs(self)end},__tostring=function(self)return self:encode():toHex()end,__add=function(bP,c1)assert(bP:isOnCurve(),"invalid point")assert(c1:isOnCurve(),"invalid point")return c0(bP,c1)end,__sub=function(bP,c1)assert(bP:isOnCurve(),"invalid point")assert(c1:isOnCurve(),"invalid point")return c8(bP,c1)end,__unm=function(self)assert(self:isOnCurve(),"invalid point")return c7(self)end,__eq=function(bP,c1)assert(bP:isOnCurve(),"invalid point")assert(c1:isOnCurve(),"invalid point")return ca(bP,c1)end,__mul=function(bP,p)if type(bP)=="number"then return p*bP end;if type(p)=="number"then assert(p<2^24,"number multiplier too big")p={p,0,0,0,0,0,0}else p=bx(p)end;if bP==bM then return cr(p)else return cl(p,bP)end end}bM=setmetatable(bM,bI)bN=setmetatable(bN,bI)return{G=bM,O=bN,pointDecode=cv}end)()local function cD(cE,cF,cG)local cF=type(cF)=="table"and string.char(unpack(cF))or tostring(cF)local cH=bH.pointDecode(cE)local P=bm.decodeModQ({unpack(cG,1,#cG/2)})local p=bm.decodeModQ({unpack(cG,#cG/2+1)})local cI=bH.G*p+cH*P;local cJ=bm.hashModQ(cF..tostring(cI))return cJ==P end;local cK=true;local cL=false;local cM={ 209,185,174,38,208,178,229,121,175,146,164,17,42,14,253,139,216,209,73,199,189,1 }local function cN(cO,cP)local cP,cQ=cP,{}local cR=string.format("([^%s]+)",cP)cO:gsub(cR,function(N)cQ[#cQ+1]=N end)return cQ end;local function cS()if sim.isOnlineRace then local cT=ac.INIConfig.onlineExtras()if cT==nil then return false end;local cU=cT:get("ACI_ENTITLEMENTS",ac.getCarID(0))if cU==nil or#cU==0 then return false end;local cV=stringify.parse(cU[1])local cL=cD(cM,cV.msg,{ac.decodeBase64(cV.sig):byte(1,-1)})if not cL then return false end;local cW=cN(cV.msg,",")local cX=ac.getServerIP()if cW[1]~=ac.getCarID(0)then return false end;for e,cY in ipairs(cW)do if cY==cX then return true end end;return false else return cK end end;try(function()cL=cS()end,function(cZ)ac.debug("err",cZ)cL=false end)function script.update(c_)if not cL then ac.accessCarPhysics().gas=1 else ac.setWingGain(0,1,1)end end
