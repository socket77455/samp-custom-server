#include <a_samp>

new InHeli[MAX_PLAYERS];

public OnFilterScriptInit()
{
	AddStaticPickup(371, 2, 312.6013, 1020.9985, 1950.6046); // Parachute 1
	AddStaticPickup(371, 2, 312.6560, 1019.1441, 1951.0325); // Parachute 2
	AddStaticPickup(371, 2, 312.5144, 1017.2626, 1951.4667); // Parachute 3
	AddStaticPickup(371, 2, 319.0721, 1021.3286, 1950.5284); // Parachute 4
	AddStaticPickup(371, 2, 319.0938, 1017.5636, 1951.3972); // Parachute 5
	AddStaticPickup(371, 2, 319.0139, 1019.4077, 1950.9717); // Parachute 6
	
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	InHeli[playerid] = 0;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    if (GetVehicleModel(vehicleid) == 548)
	    {
            SetPlayerPos(playerid, 315.9116,973.5352,1961.7387);
			SetPlayerFacingAngle(playerid, 0);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 9);
	        InHeli[playerid] = vehicleid;
	    }
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PlayerToPoint(10.0,playerid,315.9260,1038.2631,1944.8386) && InHeli[playerid] > 0)
	{
		new Float:X,Float:Y,Float:Z;
		GetVehiclePos(InHeli[playerid], X, Y, Z);
		SetPlayerPos(playerid, X, Y-7, Z);
		SetPlayerInterior(playerid, 0);
		InHeli[playerid] = 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(InHeli[playerid] == 1)
	{
		InHeli[playerid] = 0;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	InHeli[playerid] = 0;
	return 1;
}

PlayerToPoint(Float:radius, playerid, Float:X, Float:Y, Float:Z)
{
    new Float:oldpos[3], Float:temppos[3];
    GetPlayerPos(playerid, oldpos[0], oldpos[1], oldpos[2]);
    temppos[0] = (oldpos[0] -X);
    temppos[1] = (oldpos[1] -Y);
    temppos[2] = (oldpos[2] -Z);
    if(((temppos[0] < radius) && (temppos[0] > -radius)) && ((temppos[1] < radius) && (temppos[1] > -radius)) && ((temppos[2] < radius) && (temppos[2] > -radius)))
   	{
        return true;
    }
    return false;
}
