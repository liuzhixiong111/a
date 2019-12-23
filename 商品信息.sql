/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2019/12/22 19:15:13                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Relationship_1') and o.name = 'FK_RELATION_RELATIONS_SUPPLIER')
alter table Relationship_1
   drop constraint FK_RELATION_RELATIONS_SUPPLIER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Relationship_1') and o.name = 'FK_RELATION_RELATIONS_COMMODIT')
alter table Relationship_1
   drop constraint FK_RELATION_RELATIONS_COMMODIT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('commodity') and o.name = 'FK_COMMODIT_RELATIONS_BRAND')
alter table commodity
   drop constraint FK_COMMODIT_RELATIONS_BRAND
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('commodity') and o.name = 'FK_COMMODIT_RELATIONS_TYPE')
alter table commodity
   drop constraint FK_COMMODIT_RELATIONS_TYPE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"order"') and o.name = 'FK_ORDER_RELATIONS_COMMODIT')
alter table "order"
   drop constraint FK_ORDER_RELATIONS_COMMODIT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Relationship_1')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Relationship_1.Relationship_2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Relationship_1')
            and   name  = 'Relationship_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index Relationship_1.Relationship_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Relationship_1')
            and   type = 'U')
   drop table Relationship_1
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Supplier')
            and   type = 'U')
   drop table Supplier
go

if exists (select 1
            from  sysobjects
           where  id = object_id('brand')
            and   type = 'U')
   drop table brand
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('commodity')
            and   name  = 'Relationship_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index commodity.Relationship_4_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('commodity')
            and   name  = 'Relationship_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index commodity.Relationship_3_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('commodity')
            and   type = 'U')
   drop table commodity
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"order"')
            and   name  = 'Relationship_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index "order".Relationship_5_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"order"')
            and   type = 'U')
   drop table "order"
go

if exists (select 1
            from  sysobjects
           where  id = object_id('type')
            and   type = 'U')
   drop table type
go

/*==============================================================*/
/* Table: Relationship_1                                        */
/*==============================================================*/
create table Relationship_1 (
   sname                varchar(50)          not null,
   cno                  int                  not null,
   constraint PK_RELATIONSHIP_1 primary key (sname, cno)
)
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/
create index Relationship_1_FK on Relationship_1 (
sname ASC
)
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on Relationship_1 (
cno ASC
)
go

/*==============================================================*/
/* Table: Supplier                                              */
/*==============================================================*/
create table Supplier (
   sname                varchar(50)          not null,
   contacts             varchar(10)          not null,
   phone                varchar(20)          not null,
   synopsis             varchar(100)         not null,
   constraint PK_SUPPLIER primary key nonclustered (sname)
)
go

/*==============================================================*/
/* Table: brand                                                 */
/*==============================================================*/
create table brand (
   bname                varchar(50)          not null,
   bwebsite             varchar(100)         not null,
   bpicture             varchar(100)         not null,
   constraint PK_BRAND primary key nonclustered (bname)
)
go

/*==============================================================*/
/* Table: commodity                                             */
/*==============================================================*/
create table commodity (
   cno                  int                  not null,
   bname                varchar(50)          null,
   tname                varchar(50)          null,
   cname                varchar(50)          not null,
   gg                   varchar(50)          not null,
   xh                   varchar(50)          not null,
   jldw                 varchar(10)          not null,
   scj                  numeric(16,2)        not null
      constraint CKC_SCJ_COMMODIT check (scj >= 0),
   xsj                  numeric(16,2)        not null
      constraint CKC_XSJ_COMMODIT check (xsj >= 0),
   cbj                  numeric(16,2)        not null
      constraint CKC_CBJ_COMMODIT check (cbj >= 0),
   slt                  varchar(50)          not null,
   js                   varchar(100)         not null,
   kc                   int                  not null
      constraint CKC_KC_COMMODIT check (kc >= 0),
   constraint PK_COMMODITY primary key nonclustered (cno)
)
go

/*==============================================================*/
/* Index: Relationship_3_FK                                     */
/*==============================================================*/
create index Relationship_3_FK on commodity (
bname ASC
)
go

/*==============================================================*/
/* Index: Relationship_4_FK                                     */
/*==============================================================*/
create index Relationship_4_FK on commodity (
tname ASC
)
go

/*==============================================================*/
/* Table: "order"                                               */
/*==============================================================*/
create table "order" (
   ono                  int                  not null,
   cno                  int                  null,
   khxm                 varchar(10)          not null,
   khsj                 varchar(30)          not null,
   khdz                 varchar(50)          not null,
   yb                   varchar(16)          not null,
   dgsj                 datetime             not null,
   dgsl                 int                  not null
      constraint CKC_DGSL_ORDER check (dgsl >= 0),
   dj                   numeric(16,0)        not null
      constraint CKC_DJ_ORDER check (dj >= 0),
   dgzje                numeric(32,0)        not null
      constraint CKC_DGZJE_ORDER check (dgzje >= 0),
   constraint PK_ORDER primary key nonclustered (ono)
)
go

/*==============================================================*/
/* Index: Relationship_5_FK                                     */
/*==============================================================*/
create index Relationship_5_FK on "order" (
cno ASC
)
go

/*==============================================================*/
/* Table: type                                                  */
/*==============================================================*/
create table type (
   tname                varchar(50)          not null,
   tpicture             varchar(100)         not null,
   constraint PK_TYPE primary key nonclustered (tname)
)
go

alter table Relationship_1
   add constraint FK_RELATION_RELATIONS_SUPPLIER foreign key (sname)
      references Supplier (sname)
go

alter table Relationship_1
   add constraint FK_RELATION_RELATIONS_COMMODIT foreign key (cno)
      references commodity (cno)
go

alter table commodity
   add constraint FK_COMMODIT_RELATIONS_BRAND foreign key (bname)
      references brand (bname)
go

alter table commodity
   add constraint FK_COMMODIT_RELATIONS_TYPE foreign key (tname)
      references type (tname)
go

alter table "order"
   add constraint FK_ORDER_RELATIONS_COMMODIT foreign key (cno)
      references commodity (cno)
go

