package flexclient.model.enum
{
    [Bindable]
    public class ParticipantsEnum
    {
        public static const NONE_SELECTED:ParticipantsEnum    = new ParticipantsEnum('(None Selected)' , 0);
        public static const BREANNA_GALLASIN:ParticipantsEnum = new ParticipantsEnum('Breanna Gallasin', 1);
        public static const FYRA_GINN:ParticipantsEnum        = new ParticipantsEnum('Fyra Ginn'       , 2);
        public static const JAKUU_RETWIN:ParticipantsEnum     = new ParticipantsEnum('Jakuu Retwin'    , 3);
        public static const JERAN_CORSE:ParticipantsEnum      = new ParticipantsEnum('Jeran Corse'     , 4);
        public static const KAVINDRA_SUDIME:ParticipantsEnum  = new ParticipantsEnum('Kavindra Sudime' , 5);
        public static const KEN_GUNDO:ParticipantsEnum        = new ParticipantsEnum('Ken Gundo'       , 6);
        public static const KITREP_STARR:ParticipantsEnum     = new ParticipantsEnum('Kitrep Starr'    , 7);
        public static const MEERAVAL_SOTO:ParticipantsEnum    = new ParticipantsEnum('Meeraval Soto'   , 8);
        public static const MILKA_PRAXON:ParticipantsEnum     = new ParticipantsEnum('Milka Praxon'    , 9);
        public static const MURGH_ASHEN:ParticipantsEnum      = new ParticipantsEnum('Murgh Ashen'     ,10);
        public static const RUNDO_QUAMAR:ParticipantsEnum     = new ParticipantsEnum('Rundo Quamar'    ,11);
        public static const ULDIR_GREETA:ParticipantsEnum     = new ParticipantsEnum('Uldir Greeta'    ,12);
        public static const VASH_CARI:ParticipantsEnum        = new ParticipantsEnum('Vash Cari'       ,13);
        public static const ZARLI_ORDEN:ParticipantsEnum      = new ParticipantsEnum('Zarli Orden'     ,14);
        
        public var ordinal:int;
        public var value:String;
        
        public function ParticipantsEnum(value:String, ordinal:int)
        {
            this.value = value;
            this.ordinal = ordinal;
        }

        public static function get list():Array
        {
            return [ NONE_SELECTED,
                     BREANNA_GALLASIN,
                     FYRA_GINN,
                     JAKUU_RETWIN,
                     JERAN_CORSE,
                     KAVINDRA_SUDIME,
                     KEN_GUNDO,
                     KITREP_STARR,
                     MEERAVAL_SOTO,
                     MILKA_PRAXON,
                     MURGH_ASHEN,
                     RUNDO_QUAMAR,
                     ULDIR_GREETA,
                     VASH_CARI,
                     ZARLI_ORDEN
                   ];
        }

        public function equals(enum:ParticipantsEnum):Boolean
        {
            return(this.ordinal == enum.ordinal && this.value == enum.value);
        }
    }
}
