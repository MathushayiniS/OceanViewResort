/**
 * Main Javascript logic for Ocean View Resort
 */
document.addEventListener("DOMContentLoaded", () => {
    
    // Auto-hide alert messages after 5 seconds if they exist
    const alerts = document.querySelectorAll('.alert');
    if(alerts) {
        setTimeout(() => {
            alerts.forEach(a => {
                a.style.opacity = '0';
                a.style.transition = 'opacity 0.6s ease';
                setTimeout(() => a.remove(), 600);
            });
        }, 5000);
    }
    
    // Setup available room checker script on add-reservation page
    const checkAvailableBtn = document.getElementById('btnCheckRooms');
    if (checkAvailableBtn) {
        checkAvailableBtn.addEventListener('click', async (e) => {
            e.preventDefault();
            const checkIn = document.getElementById('checkIn').value;
            const checkOut = document.getElementById('checkOut').value;
            const roomSelect = document.getElementById('roomId');
            const statusDiv = document.getElementById('roomAvailabilityStatus');
            
            if (!checkIn || !checkOut) {
                statusDiv.innerHTML = '<span style="color: var(--error-color);"><i class="fa-solid fa-circle-xmark"></i> Please select both Check-In and Check-Out dates first.</span>';
                return;
            }
            
            if (new Date(checkOut) <= new Date(checkIn)) {
                statusDiv.innerHTML = '<span style="color: var(--error-color);"><i class="fa-solid fa-circle-xmark"></i> Check-Out must be after Check-In.</span>';
                return;
            }

            statusDiv.innerHTML = '<span style="color: var(--secondary-color);"><i class="fa-solid fa-spinner fa-spin"></i> Checking availability...</span>';

            try {
                // Fetch JSON from REST Servlet
                const response = await fetch(`${window.location.origin}/OceanView/api/rooms/available?checkIn=${checkIn}&checkOut=${checkOut}`);
                
                if (!response.ok) throw new Error("Failed to fetch rooms");

                const rooms = await response.json();
                
                roomSelect.innerHTML = '';
                
                if (rooms.length === 0) {
                    statusDiv.innerHTML = '<span style="color: var(--error-color);"><i class="fa-solid fa-circle-exclamation"></i> No rooms available for these dates!</span>';
                    roomSelect.innerHTML = '<option value="">-- No available rooms --</option>';
                    roomSelect.disabled = true;
                } else {
                    statusDiv.innerHTML = `<span style="color: var(--success-color);"><i class="fa-solid fa-circle-check"></i> ${rooms.length} room(s) available.</span>`;
                    roomSelect.disabled = false;
                    
                    rooms.forEach(room => {
                        const opt = document.createElement('option');
                        opt.value = room.id;
                        opt.textContent = `${room.roomType} (Room ${room.roomNumber}) - $${room.pricePerNight} /night`;
                        roomSelect.appendChild(opt);
                    });
                }
            } catch (err) {
                console.error(err);
                statusDiv.innerHTML = '<span style="color: var(--error-color);"><i class="fa-solid fa-circle-xmark"></i> Error checking availability. Check server connection.</span>';
            }
        });
    }
    
});
