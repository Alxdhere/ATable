static HINSTANCE vclInstance = NULL;

//enum TAlxdCellTextType {cttsDefault, cttsMText, cttsDText, cttsBText};
//enum TAlxdCellTextHorAlignment {cthaDefault, cthaLeft, cthaCenter, cthaRight};
//enum TAlxdCellTextVerAlignment {ctvaDefault, ctvaTop, ctvaMiddle, ctvaBaseline, ctvaBottom};
//enum TAlxdCellTextFit {ctfsDefault, ctfsFit, ctfsBreak, ctfsUnbreaked, ctfsFitted};

struct TAlxdJoined
{
	int Cols;
	int Rows;
};

struct TWasLocked
{
	bool TextLayer;
	bool VerBorderLayer;
	bool HorBorderLayer;
};
typedef struct TWasLocked *PWasLocked;

struct TDrawingPair
{
	double x;
	double y;
};
typedef struct TDrawingPair *PDrawingPair;

struct TAlxdMargins
{
	double Left;
	double Bottom;
	double Right;
	double Top;
};
typedef struct TAlxdMargins *PAlxdMargins;
/*
struct TJoined
{
	int Cols;
	int Rows;
};
typedef struct TJoined *PJoined;
*/

struct TAlxdSpreadSheetStyleExchange
{
	int		ColCount;
    int		RowCount;
    double	DefaultSize;
    char	Primary;
    char	Justify;

    char	DrawBorder;
    char	FillCell;
    char	TextFit;
    char	TextType;

    ACHAR*	StyleName;
    ACHAR*	TextStyleName;
    ACHAR*	TextStyleFontName;
    ACHAR*	TextStyleBigFontName;

    double	TextHeight;
    double	TextWidthFactor;
    double	TextObliqueAngle;
    TAlxdMargins TextMargins;

    int		TextColor;
    ACHAR*	TextLayer;
    int		TextWeight;

    int		VerBorderColor;
    ACHAR*	VerBorderLayer;
    int		VerBorderWeight;

    int		HorBorderColor;
    ACHAR*	HorBorderLayer;
    int		HorBorderWeight;

    ACHAR*	HeaderFileName;
    ACHAR*	HeaderBlockName;

    bool	Lock;

    ACHAR*	Note;
	ACHAR*	Data;
};
typedef struct TAlxdSpreadSheetStyleExchange *PAlxdSpreadSheetStyleExchange;

struct TAlxdSpreadSheetExchange
{
	Adesk::IntDbId	BlockDefId;
	Adesk::IntDbId	BlockRefId;
	Adesk::IntDbId	BlockRefPtrJig;
    Adesk::IntDbId	DictionaryId;
    Adesk::IntDbId	HeaderRefId;

    ads_point	BlockDefInsPt;
    ads_point	BlockRefInsPt;
    ads_point	BlockRefSclFt;
};
typedef struct TAlxdSpreadSheetExchange *PAlxdSpreadSheetExchange;

struct TAlxdItemExchange
{
	double	Size;		//1
	ACHAR*  Title;		//4
	char	HorizontalAlignment;
	char	VerticalAlignment;
	bool	Visible;	//4
};
typedef struct TAlxdItemExchange *PAlxdItemExchange;
typedef PAlxdItemExchange (* TAlxdItemExchangeFunc)(Adesk::IntDbId, int);

struct TAlxdBorderExchange
{
	char	State;		//1

	int		Color;		//4
	ACHAR*  Layer;		//4
	int		Weight;		//4
	Adesk::IntDbId	ObjectId;	//4
};
typedef struct TAlxdBorderExchange *PAlxdBorderExchange;
typedef PAlxdBorderExchange (* TAlxdBorderExchangeFunc)(Adesk::IntDbId, int, int);

struct TAlxdFillExchange
{
	TDrawingPair Coord;
	TDrawingPair Size;
	char	FillType;
	int		LineCount;
	Adesk::IntDbId*	ObjectIds;

	bool	IsRotatedCell;
	double	DefaultSize;

	ACHAR*	HatchName;
	int		HatchColor;
	char	HatchType;
	Adesk::IntDbId	HatchId;
};
typedef struct TAlxdFillExchange *PAlxdFillExchange;
typedef PAlxdFillExchange (* TAlxdFillExchangeFunc)(Adesk::IntDbId, int, int);

struct TAlxdCellExchange
{
	ACHAR*	Text;					//4
	ACHAR*	Formula;				//4
	char	TextType;		//1
	bool	MTextBackgroundMaskState;
	
	//ACHAR*	TextStyleName;
	Adesk::IntDbId	TextStyleObjectId;

	double	Height;					//8
	double	WidthFactor;			//8
	double	ObliqueAngle;			//8
	double	Between;				//8
	double	Rotation;				//8

	char	HorizontalAlignment;//1
	char	VerticalAlignment;	//1
	char	TextFit;			//1

	TAlxdMargins	Margins;							//TMargins = 32
	bool	IsJoiningCell;
	bool	IsResetedCell;
	bool	IsVisibleCell;

	int		Color;					//4
	ACHAR*	Layer;					//4
	int		Weight;					//4
	TAlxdJoined		Joined;
	Adesk::IntDbId*	ObjectIds;		//4
	double	DefaultSize;

};
typedef struct TAlxdCellExchange *PAlxdCellExchange;
typedef PAlxdCellExchange (* TAlxdCellExchangeFunc)(Adesk::IntDbId, int, int);

typedef long (*pvclGetLength)(Adesk::IntDbId*);
typedef void (*pvclSetLength)(Adesk::IntDbId*&, long);
typedef void (*pvclSetAt)(Adesk::IntDbId*&, long, Adesk::IntDbId);
typedef Adesk::IntDbId (*pvclGetAt)(Adesk::IntDbId*, long);

typedef void (*pvclUpdString)(const ACHAR*, ACHAR*&);
typedef void (*pvclDelString)(ACHAR*&);

typedef void (*pvclOpm)(int, ACHAR*);

class vclImport
{
public:
	static pvclGetLength vclGetLength;
	static pvclSetLength vclSetLength;
	static pvclSetAt vclSetAt;
	static pvclGetAt vclGetAt;

	static pvclUpdString vclUpdString;
	static pvclDelString vclDelString;

	static pvclOpm vclOPMName;
	static pvclOpm vclOPMDescription;
	static pvclOpm vclOPMMessages;
};