namespace FoxKit.IH
{
    using System.Collections.Generic;
    using UnityEditor;
    using UnityEngine;

    /// <summary>
    /// Visualizes quest area boundaries.    
    /// Usage: Add script to a gameobject and change its settings via inspector
    /// Notes:
    /// Data in fox engine coords from TppQuestList.lua
    /// Translated to unity just before draw
    /// also blockX, blockY becomes vector X,Z
    /// </summary>
    public class DrawQuestArea : MonoBehaviour
    {
        public Color LoadBoundsColor = new Color(0.0f, 1.0f, 0.0f, 1.0f);
        public Color ActiveBoundsColor = new Color(0.0f, 0.9f, 0.2f, 1.0f);
        public Color BlockColor = Color.red;
        public bool DrawOver = true;//tex draw over the rest of the rendering (else terrain/models will hide it).
        public bool DrawName = true;
        
        public bool DrawAllBlocks = false;
        public bool DrawAllQuestAreas = false;
        public bool DrawBlockCenterIndex = false;
        public bool DrawAreaCenterIndex = true;
        public float yLevel = 0.0f;

        public enum Locations
        {
            afgh,
            mafr,
        };
        public Locations location;


        static int blockStartIndex = 101; //tex from lowest small block / pack_small pack name, small_lod starts at 100 though
        //tex from StageBlockControllerData
        static int blockSizeX = 128;
        static int blockSizeY = 128;

        //tex GOTCHA based on afgh/mafr
        static int mapSize = 8192;
        static int mapStart = -mapSize / 2; //tex map is centered at 0,0,0

        //tex in block index x,y
        struct Bounds
        {
            public Vector2 mins;
            public Vector2 maxs;
        }

        struct QuestArea {
            public string name;
            public Bounds loadExtents;
            public Bounds activeExtents;
        }

        // Data from TppQuestList.lua
        QuestArea[] questAreasAfgh = new QuestArea[] {
            new QuestArea {
                name = "tent",
                loadExtents = new Bounds {
                    mins = new Vector2(116, 134),
                    maxs = new Vector2(131, 152),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(117, 135),
                    maxs = new Vector2(130, 151),
                },
            },
            new QuestArea {
                name = "field",
                loadExtents = new Bounds {
                    mins = new Vector2(132,138),
                    maxs = new Vector2(139,155),
                    },
                activeExtents = new Bounds {
                    mins = new Vector2(133,139),
                    maxs = new Vector2(138,154),
                },
            },

            new QuestArea {
                name = "ruins",
                loadExtents = new Bounds {
                    mins = new Vector2(140,138),
                    maxs = new Vector2(148,154),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(141,139),
                    maxs = new Vector2(147,153),
                },
            },
            new QuestArea {
                name = "waterway",
                loadExtents = new Bounds {
                    mins = new Vector2(117,125),
                    maxs = new Vector2(131,133),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(118,126),
                    maxs = new Vector2(130,132),
                },
            },
            new QuestArea {
                name = "cliffTown",
                loadExtents = new Bounds {
                    mins = new Vector2(132,120),
                    maxs = new Vector2(141,137),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(133,121),
                    maxs = new Vector2(140,136),
                },
            },
            new QuestArea {
                name = "commFacility",
                loadExtents = new Bounds {
                    mins = new Vector2(142,128),
                    maxs = new Vector2(153,137),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(143,129),
                    maxs = new Vector2(152,136),
                },
            },
            new QuestArea {
                name = "sovietBase",
                loadExtents = new Bounds {
                    mins = new Vector2(112,114),
                    maxs = new Vector2(131,124),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(113,115),
                    maxs = new Vector2(130,123),
                },
            },
            new QuestArea {
                name = "fort",
                loadExtents = new Bounds {
                    mins = new Vector2(142,116),
                    maxs = new Vector2(153,127),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(143,117),
                    maxs = new Vector2(152,126),
                },
            },
            new QuestArea {
                name = "citadel",
                loadExtents = new Bounds {
                    mins = new Vector2(118,105),
                    maxs = new Vector2(125,113),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(119,106),
                    maxs = new Vector2(124,112),
                },
            },
        };//questAreasAfgh

        QuestArea[] questAreasMafr = new QuestArea[] {
            new QuestArea {
                name = "outland",
                loadExtents = new Bounds {
                    mins = new Vector2(121,124),
                    maxs = new Vector2(132,150),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(122,125),
                    maxs = new Vector2(131,149),
                },
            },
            new QuestArea {
                name = "pfCamp",
                loadExtents = new Bounds {
                    mins = new Vector2(133, 139),
                    maxs = new Vector2(148, 150),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(134, 140),
                    maxs = new Vector2(147, 149),
                },
            },
            new QuestArea {
                name = "savannah",
                loadExtents = new Bounds {
                    mins = new Vector2(133,129),
                    maxs = new Vector2(145,138),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(134,130),
                    maxs = new Vector2(144,137),
                },
            },
            new QuestArea {
                name = "hill",
                loadExtents = new Bounds {
                    mins = new Vector2(146,129),
                    maxs = new Vector2(159,138),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(147,130),
                    maxs = new Vector2(158,137),
                },
            },
            new QuestArea {
                name = "banana",
                loadExtents = new Bounds {
                    mins = new Vector2(133,110),
                    maxs = new Vector2(141,128),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(134,111),
                    maxs = new Vector2(140,127),
                },
            },
            new QuestArea {
                name = "diamond",
                loadExtents = new Bounds {
                    mins = new Vector2(142,110),
                    maxs = new Vector2(149,128),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(143,111),
                    maxs = new Vector2(148,127),
                },
            },
            new QuestArea {
                name = "lab",
                loadExtents = new Bounds {
                    mins = new Vector2(150,110),
                    maxs = new Vector2(159,128),
                },
                activeExtents = new Bounds {
                    mins = new Vector2(151,111),
                    maxs = new Vector2(158,127),
                },
            },
        };//questAreasMafr

        private void OnDrawGizmos()
        {
            if (DrawAllBlocks) {
                DrawBlocks(yLevel);
            }
            if (DrawAllQuestAreas) {
                DrawQuestAreas();
            }
        }//OnDrawGizmos

        private void DrawBlocks(float yLevel = 0.0f) {
            Handles.zTest = UnityEngine.Rendering.CompareFunction.Less;
            if (DrawOver) {
                Handles.zTest = UnityEngine.Rendering.CompareFunction.Always;
            }
            Handles.color = BlockColor;

            for (int x = mapStart; x <= mapSize / 2; x += blockSizeX) {
                var startPos = new Vector3(x, yLevel, mapStart + 0);
                var endPos = new Vector3(x, yLevel, mapStart + mapSize);
                startPos.x = -startPos.x;//fox to unity ala FoxUtils
                endPos.x = -endPos.x;//fox to unity ala FoxUtils

                Handles.DrawLine(startPos, endPos);
            }

            for (int y = mapStart; y <= mapSize / 2; y += blockSizeX) {
                var startPos = new Vector3(mapStart + 0, yLevel, y);
                var endPos = new Vector3(mapStart + mapSize, yLevel, y);
                startPos.x = -startPos.x;//fox to unity ala FoxUtils
                endPos.x = -endPos.x;//fox to unity ala FoxUtils

                Handles.DrawLine(startPos, endPos);
            }

            //DEBUGNOW urg
            if (DrawBlockCenterIndex) {
                for (int blockX = 0; blockX <= mapSize; blockX = blockX + blockSizeX) {
                    for (int blockY = 0; blockY <= mapSize; blockY = blockY + blockSizeY) {
                        var centerX = mapStart+blockX;
                        var centerY = mapStart+blockY;

                        var centerPos = new Vector3(centerX, yLevel, centerY);
                        centerPos.x = -centerPos.x;//fox to unity ala FoxUtils
                        Handles.color = Color.white;
                        Handles.zTest = UnityEngine.Rendering.CompareFunction.Greater;
                        string centerIndexText = "[" + blockX + ", " + blockY + "]";
                        Handles.Label(centerPos, centerIndexText);    
                    }                    
                }
            }//DrawBlockCenterIndex
        }//DrawBlocks

        private void DrawQuestAreas()
        {
            var questAreas = questAreasAfgh;
            switch (location)
            {
                case Locations.mafr:
                    questAreas = questAreasMafr;
                break;
                default:
                    break;
            }

            foreach (var questArea in questAreas)
            {
                var centerX = Mathf.Floor(questArea.loadExtents.mins.x + ((questArea.loadExtents.maxs.x - questArea.loadExtents.mins.x) / 2.0f));
                var centerY = Mathf.Floor(questArea.loadExtents.mins.y + ((questArea.loadExtents.maxs.y - questArea.loadExtents.mins.y) / 2.0f));

                if (DrawName)
                {
                    string centerIndexText = "";
                    if (DrawAreaCenterIndex)
                    {
                        centerIndexText = "[" + centerX + ", " + centerY + "]";
                    }

                    centerX = centerX - blockStartIndex;
                    centerY = centerY - blockStartIndex;
                    var centerPos = new Vector3(mapStart + (blockSizeX * centerX), yLevel, mapStart + (blockSizeY * centerY));
                    centerPos.x = -centerPos.x;//fox to unity ala FoxUtils
                    Handles.color = Color.white;
                    Handles.zTest = UnityEngine.Rendering.CompareFunction.Greater;
                    Handles.Label(centerPos,  questArea.name + "\n" + centerIndexText);
                }

                Handles.zTest = UnityEngine.Rendering.CompareFunction.Less;
                if (DrawOver)
                {
                    Handles.zTest = UnityEngine.Rendering.CompareFunction.Always;
                }
                Handles.color = LoadBoundsColor;
                DrawBlockBox(questArea.loadExtents, yLevel);
                Handles.color = ActiveBoundsColor;
                DrawBlockBox(questArea.activeExtents, yLevel);
            }
        }//DrawQuestAreas

        private static void DrawBlockBox(Bounds extents, float yLevel = 0.0f)
        {
            var minsX = extents.mins.x;
            var minsY = extents.mins.y;
            var maxsX = extents.maxs.x;
            var maxsY = extents.maxs.y;

            minsX = minsX - blockStartIndex;
            minsY = minsY - blockStartIndex;

            maxsX = maxsX - blockStartIndex;
            maxsY = maxsY - blockStartIndex;

            var startPos = new Vector3(mapStart + (minsX * blockSizeX), yLevel, mapStart + (minsY * blockSizeY));
            var endPos   = new Vector3(mapStart + (minsX * blockSizeX), yLevel, mapStart + (maxsY * blockSizeY));
            startPos.x = -startPos.x;//fox to unity ala FoxUtils
            endPos.x = -endPos.x;//fox to unity ala FoxUtils

            Handles.DrawLine(startPos, endPos);

            startPos = endPos;
            endPos   = new Vector3(mapStart + (maxsX * blockSizeX), yLevel, mapStart + (maxsY * blockSizeY));
            endPos.x = -endPos.x;

            Handles.DrawLine(startPos, endPos);

            startPos = endPos;
            endPos   = new Vector3(mapStart + (maxsX * blockSizeX), yLevel, mapStart + (minsY * blockSizeY));
            endPos.x = -endPos.x;//fox to unity ala FoxUtils

            Handles.DrawLine(startPos, endPos);

            startPos = endPos;
            endPos   = new Vector3(mapStart + (minsX * blockSizeX), yLevel, mapStart + (minsY * blockSizeY));
            endPos.x = -endPos.x;//fox to unity ala FoxUtils

            Handles.DrawLine(startPos, endPos);
        }//DrawBlockBox
    }//DrawQuestArea
}//namespace FoxKit.Utils