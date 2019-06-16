
float () Player_PreDraw {
    if (self.entnum == player_localentnum) {
        self.movetype = MOVETYPE_WALK;

        // Prepare rollback
        vector vOldOrigin = self.origin;
        vector vOldVelocity = self.velocity;
        float fOldPMoveFlags = self.pmove_flags;

        // Apply physics for every single input-frame that has not yet been
        // acknowledged by the server (servercommandframe = last acknowledged frame)
        for (float i = servercommandframe + 1; i <= clientcommandframe; i++) {
            float flSuccess = getinputstate(i);

            if (flSuccess == FALSE) {
                continue;
            }

            // Partial frames are the worst
            if (input_timelength == 0) {
                break;
            }
            runstandardplayerphysics(self);
        }
                
        // Smooth stair stepping, this has to be done manually!
        vPlayerOriginOld = vPlayerOrigin;
                
        if ((self.flags & FL_ONGROUND) && (self.origin_z - vPlayerOriginOld_z > 0)) {
            vPlayerOriginOld_z += frametime * 150;
                    
            if (vPlayerOriginOld_z > self.origin_z) {
                vPlayerOriginOld_z = self.origin_z;
            }
            if (self.origin_z - vPlayerOriginOld_z > 18) {
                vPlayerOriginOld_z = self.origin_z - 18;
            }
            vPlayerOrigin_z += vPlayerOriginOld_z - self.origin_z;
        } else {
            vPlayerOriginOld_z = self.origin_z;
        }
            
        vPlayerOrigin = [ self.origin_x, self.origin_y, vPlayerOriginOld_z ];
        vPlayerVelocity = self.velocity;
        addentity( self );

        // Time to roll back
        self.origin = vOldOrigin;
        setorigin(self, self.origin);
        self.velocity = vOldVelocity;
        self.pmove_flags = fOldPMoveFlags;
        self.movetype = MOVETYPE_NONE;

        // Set renderflag for mirrors!
        self.renderflags = RF_EXTERNALMODEL;
    } else {
        addentity(self);
    }

    return PREDRAW_NEXT;
}