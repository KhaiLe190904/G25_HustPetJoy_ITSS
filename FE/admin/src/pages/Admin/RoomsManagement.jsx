import React, { useContext, useEffect, useState } from "react";
import { assets } from "../../assets/assets";
import { AdminContext } from "../../context/AdminContext";
import { AppContext } from "../../context/AppContext";
import axios from "axios";
import { toast } from "react-toastify";

const RoomsManagement = () => {
  const { aToken } = useContext(AdminContext);
  const { backendUrl, slotDateFormat } = useContext(AppContext);
  const [rooms, setRooms] = useState([]);
  const [roomBookings, setRoomBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedPet, setSelectedPet] = useState(null);
  const [showPetModal, setShowPetModal] = useState(false);
  const [petLoading, setPetLoading] = useState(false);

  // Notes state
  const [isNotesModalOpen, setIsNotesModalOpen] = useState(false);
  const [notes, setNotes] = useState("");
  const [selectedBookingForNotes, setSelectedBookingForNotes] = useState(null);
  const [notesLoading, setNotesLoading] = useState(false);

  const [stats, setStats] = useState({
    totalRooms: 0,
    availableRooms: 0,
    bookedRooms: 0,
    totalRevenue: 0,
  });

  // Fetch all rooms
  const fetchRooms = async () => {
    try {
      const { data } = await axios.get(`${backendUrl}/api/admin/rooms`, {
        headers: { aToken },
      });
      if (data.success) {
        setRooms(data.rooms);
        setStats((prev) => ({ ...prev, totalRooms: data.rooms.length }));
      }
    } catch (error) {
      console.error(error);
      toast.error("Failed to fetch rooms");
    }
  };

  // Fetch room bookings
  const fetchRoomBookings = async () => {
    try {
      const { data } = await axios.get(
        `${backendUrl}/api/admin/room-bookings`,
        {
          headers: { aToken },
        }
      );
      if (data.success && data.roomBookings) {
        setRoomBookings(data.roomBookings);

        // Calculate stats
        const bookedRooms = data.roomBookings.filter((booking) => {
          if (booking.isAvailable) return false; // Đã cancelled

          const now = new Date();
          const endDate = new Date(booking.endDate);
          const completeDate = new Date(endDate);
          completeDate.setDate(completeDate.getDate() + 1); // Thêm 1 ngày
          completeDate.setHours(7, 0, 0, 0); // Set 7h sáng

          return now < completeDate; // Chưa complete
        }).length;

        const totalRevenue = data.roomBookings
          .filter((booking) => !booking.isAvailable)
          .reduce(
            (sum, booking) =>
              sum +
              (booking.totalPrice *
                calculateDays(booking.startDate, booking.endDate) || 0),
            0
          );

        setStats((prev) => ({
          ...prev,
          bookedRooms,
          availableRooms: prev.totalRooms - bookedRooms,
          totalRevenue,
        }));
      }
    } catch (error) {
      console.error(error);
      toast.error("Failed to fetch room bookings");
      setRoomBookings([]); // Set empty array on error
    }
  };

  // Fetch pet information
  const fetchPetInfo = async (petId) => {
    try {
      setPetLoading(true);
      const { data } = await axios.get(`${backendUrl}/api/admin/pet`, {
        headers: { aToken },
        params: { id: petId },
      });
      if (data.success) {
        setSelectedPet(data.pet);
        setShowPetModal(true);
      } else {
        toast.error(data.message || "Failed to fetch pet information");
      }
    } catch (error) {
      console.error(error);
      toast.error("Failed to fetch pet information");
    } finally {
      setPetLoading(false);
    }
  };

  // Close pet modal
  const closePetModal = () => {
    setShowPetModal(false);
    setSelectedPet(null);
  };

  // Handle Notes Modal
  const handleOpenNotesModal = (booking) => {
    setSelectedBookingForNotes(booking);
    setNotes(booking.notes || "");
    setIsNotesModalOpen(true);
  };

  const handleUpdateNotes = async () => {
    if (!selectedBookingForNotes) return;

    try {
      setNotesLoading(true);
      const response = await axios.post(
        `${backendUrl}/api/admin/notes-room`,
        {
          petRoomId: selectedBookingForNotes.petRoomId,
          notes: notes,
        },
        {
          headers: { aToken },
        }
      );

      if (response.data.success) {
        toast.success("Ghi chú đã được cập nhật thành công!");
        setIsNotesModalOpen(false);
        setNotes("");
        setSelectedBookingForNotes(null);
        // Refresh bookings to show updated notes
        await fetchRoomBookings();
      } else {
        toast.error("Không thể cập nhật ghi chú. Vui lòng thử lại.");
      }
    } catch (error) {
      console.error("Error updating notes:", error);
      toast.error("Đã xảy ra lỗi khi cập nhật ghi chú. Vui lòng thử lại.");
    } finally {
      setNotesLoading(false);
    }
  };

  const closeNotesModal = () => {
    setIsNotesModalOpen(false);
    setNotes("");
    setSelectedBookingForNotes(null);
  };

  useEffect(() => {
    if (aToken) {
      Promise.all([fetchRooms(), fetchRoomBookings()]).finally(() => {
        setLoading(false);
      });
    }
  }, [aToken]);

  // Safety check for roomBookings
  const safeRoomBookings = Array.isArray(roomBookings) ? roomBookings : [];

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric",
    });
  };

  const getBookingStatus = (booking) => {
    if (booking.isAvailable) return "Cancelled";

    const now = new Date();
    const startDate = new Date(booking.startDate);
    const endDate = new Date(booking.endDate);

    // Complete chỉ khi qua 7h sáng ngày hôm sau của endDate
    const completeDate = new Date(endDate);
    completeDate.setDate(completeDate.getDate() + 1); // Thêm 1 ngày
    completeDate.setHours(7, 0, 0, 0); // Set 7h sáng

    if (now < startDate) return "Upcoming";
    if (now >= startDate && now < completeDate) return "Active";
    if (now >= completeDate) return "Completed";

    return "Unknown";
  };

  const getStatusColor = (status) => {
    switch (status) {
      case "Active":
        return "text-green-600 bg-green-100";
      case "Upcoming":
        return "text-blue-600 bg-blue-100";
      case "Completed":
        return "text-gray-600 bg-gray-100";
      case "Cancelled":
        return "text-red-600 bg-red-100";
      default:
        return "text-gray-600 bg-gray-100";
    }
  };

  // Tính số ngày giữa startDate và endDate
  const calculateDays = (startDate, endDate) => {
    const start = new Date(startDate);
    const end = new Date(endDate);
    const diffTime = Math.abs(end - start) + 1;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays === 0 ? 1 : diffDays; // Tối thiểu 1 ngày
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="m-5">
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800 mb-2">
          Rooms Management
        </h1>
        <p className="text-gray-600">Manage pet rooms and track bookings</p>
      </div>

      {/* Stats Cards */}
      <div className="flex flex-wrap gap-4 mb-8">
        <div className="flex items-center gap-3 bg-white p-4 min-w-52 rounded-lg border-2 border-gray-100 hover:scale-105 transition-all">
          <div className="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
            <svg
              className="w-6 h-6 text-blue-600"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2z"
              ></path>
            </svg>
          </div>
          <div>
            <p className="text-xl font-semibold text-gray-600">
              {stats.totalRooms}
            </p>
            <p className="text-gray-400">Total Rooms</p>
          </div>
        </div>

        <div className="flex items-center gap-3 bg-white p-4 min-w-52 rounded-lg border-2 border-gray-100 hover:scale-105 transition-all">
          <div className="w-12 h-12 bg-orange-100 rounded-full flex items-center justify-center">
            <svg
              className="w-6 h-6 text-orange-600"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
              ></path>
            </svg>
          </div>
          <div>
            <p className="text-xl font-semibold text-gray-600">
              {stats.bookedRooms}
            </p>
            <p className="text-gray-400">Booked</p>
          </div>
        </div>

        <div className="flex items-center gap-3 bg-white p-4 min-w-52 rounded-lg border-2 border-gray-100 hover:scale-105 transition-all">
          <div className="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center">
            <svg
              className="w-6 h-6 text-purple-600"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"
              ></path>
            </svg>
          </div>
          <div>
            <p className="text-xl font-semibold text-gray-600">
              ${stats.totalRevenue}
            </p>
            <p className="text-gray-400">Total Revenue</p>
          </div>
        </div>
      </div>

      {/* Room Bookings Table */}
      <div className="bg-white border rounded-lg">
        <div className="flex items-center gap-2.5 px-4 py-4 border-b">
          <svg
            className="w-5 h-5 text-gray-600"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
            ></path>
          </svg>
          <p className="font-semibold text-gray-800">Room Bookings</p>
        </div>

        <div className="text-sm max-h-[60vh] overflow-y-auto">
          {/* Table Header */}
          <div className="hidden sm:grid grid-cols-[0.5fr_2fr_2.5fr_2fr_2fr_1.5fr_1fr_1fr] py-3 px-4 border-b bg-gray-50 font-medium text-gray-700">
            <p>#</p>
            <p>Room</p>
            <p>Pet</p>
            <p>Check-in</p>
            <p>Check-out</p>
            <p>Status</p>
            <p>Price</p>
            <p>Actions</p>
          </div>

          {/* Table Body */}
          {safeRoomBookings.length > 0 ? (
            safeRoomBookings.map((booking, index) => {
              const status = getBookingStatus(booking);
              return (
                <div
                  key={index}
                  className="grid grid-cols-[0.5fr_2fr_2.5fr_2fr_2fr_1.5fr_1fr_1fr] items-center text-gray-600 py-3 px-4 border-b hover:bg-gray-50"
                >
                  <p className="text-gray-400">{index + 1}</p>

                  <div className="flex items-center gap-2">
                    <img
                      src={booking.roomImage || assets.room_placeholder}
                      alt={booking.roomName}
                      className="w-8 h-8 rounded object-cover bg-gray-200"
                    />
                    <p className="font-medium">{booking.roomName}</p>
                  </div>

                  <div className="flex items-center gap-2">
                    <img
                      src={booking.petImage || assets.pet_placeholder}
                      alt={booking.petName}
                      className="w-8 h-8 rounded-full object-cover bg-gray-200"
                    />
                    <div>
                      <p className="font-medium">{booking.petName}</p>
                      <p className="text-xs text-gray-400">
                        {booking.petSpecies}
                      </p>
                    </div>
                  </div>

                  <div>
                    <p className="text-sm text-gray-500">In:</p>
                    <p className="font-medium">
                      {formatDate(booking.startDate)}
                    </p>
                  </div>

                  <div>
                    <p className="text-sm text-gray-500">Out:</p>
                    <p className="font-medium">{formatDate(booking.endDate)}</p>
                  </div>

                  <span
                    className={`px-2 py-1 rounded-full text-xs font-medium ${getStatusColor(
                      status
                    )}`}
                  >
                    {status}
                  </span>

                  <div className="text-right">
                    <p className="text-lg font-bold text-green-700">
                      $
                      {booking.totalPrice *
                        calculateDays(booking.startDate, booking.endDate)}
                    </p>
                  </div>

                  <div className="text-center">
                    <div className="flex flex-col gap-1">
                      <button
                        onClick={() => fetchPetInfo(booking.petId)}
                        disabled={petLoading}
                        className="px-3 py-1 bg-blue-600 text-white text-xs rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                      >
                        {petLoading ? "Loading..." : "View Pet"}
                      </button>
                      {!booking.isAvailable && (
                        <button
                          onClick={() => handleOpenNotesModal(booking)}
                          disabled={notesLoading}
                          className="px-3 py-1 bg-orange-600 text-white text-xs rounded-lg hover:bg-orange-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                          {booking.notes ? "Edit Notes" : "Add Notes"}
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              );
            })
          ) : (
            <div className="text-center py-8 text-gray-500">
              <p>No room bookings found</p>
            </div>
          )}
        </div>
      </div>

      {/* Pet Information Modal */}
      {showPetModal && selectedPet && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-md w-full mx-4 max-h-[90vh] overflow-y-auto">
            <div className="flex justify-between items-center mb-4">
              <h2 className="text-xl font-bold text-gray-800">
                Pet Information
              </h2>
              <button
                onClick={closePetModal}
                className="text-gray-500 hover:text-gray-700 text-2xl"
              >
                ×
              </button>
            </div>

            <div className="space-y-4">
              {/* Pet Image */}
              <div className="text-center">
                <img
                  src={selectedPet.image || assets.pet_placeholder}
                  alt={selectedPet.name}
                  className="w-24 h-24 rounded-full object-cover mx-auto bg-gray-200"
                />
              </div>

              {/* Pet Details */}
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="text-sm font-medium text-gray-600">
                    Name
                  </label>
                  <p className="text-gray-800 font-medium">
                    {selectedPet.name}
                  </p>
                </div>

                <div>
                  <label className="text-sm font-medium text-gray-600">
                    Species
                  </label>
                  <p className="text-gray-800">{selectedPet.species}</p>
                </div>

                <div>
                  <label className="text-sm font-medium text-gray-600">
                    Breed
                  </label>
                  <p className="text-gray-800">
                    {selectedPet.species || "Not specified"}
                  </p>
                </div>

                <div>
                  <label className="text-sm font-medium text-gray-600">
                    Weight
                  </label>
                  <p className="text-gray-800">
                    {selectedPet.weight
                      ? `${selectedPet.weight} kg`
                      : "Not specified"}
                  </p>
                </div>
                <div>
                  <label className="text-sm font-medium text-gray-600">
                    Health
                  </label>
                  <p className="text-gray-800">
                    {selectedPet.health
                      ? `${selectedPet.health}`
                      : "Not specified"}
                  </p>
                </div>
              </div>

              {/* Special Notes */}
              {selectedPet.note && (
                <div className="border-t pt-4">
                  <h3 className="text-lg font-medium text-gray-800 mb-2">
                    Special Notes
                  </h3>
                  <p className="text-gray-700 text-sm">{selectedPet.note}</p>
                </div>
              )}
            </div>

            <div className="flex justify-end mt-6">
              <button
                onClick={closePetModal}
                className="px-4 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition-colors"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Notes Modal */}
      {isNotesModalOpen && selectedBookingForNotes && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div
            className={`bg-white rounded-2xl shadow-xl w-full max-w-lg transform transition-all duration-300 ${
              isNotesModalOpen ? "scale-100 opacity-100" : "scale-95 opacity-0"
            }`}
          >
            <div className="p-6 border-b border-gray-100">
              <h2 className="text-xl font-bold text-gray-800">
                {selectedBookingForNotes.notes
                  ? "Chỉnh Sửa Ghi Chú Phòng"
                  : "Thêm Ghi Chú Phòng"}
              </h2>
              <p className="text-sm text-gray-500 mt-1">
                Phòng: {selectedBookingForNotes.roomName}
              </p>
              <p className="text-sm text-gray-500">
                Thú cưng: {selectedBookingForNotes.petName}
              </p>
            </div>

            <div className="p-6">
              <label className="block text-sm font-medium text-gray-700 mb-3">
                Ghi Chú Quản Lý Phòng
              </label>
              <textarea
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                placeholder="Nhập ghi chú về tình trạng phòng, thú cưng, yêu cầu đặc biệt..."
                className="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-colors duration-200 resize-none"
                rows="6"
              />
              <p className="text-xs text-gray-500 mt-2">
                Ghi chú này sẽ được hiển thị cho khách hàng khi họ xem thông tin
                đặt phòng.
              </p>
            </div>

            <div className="p-6 border-t border-gray-100 flex justify-end gap-3">
              <button
                onClick={closeNotesModal}
                disabled={notesLoading}
                className="px-6 py-2 rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors duration-200 disabled:opacity-50"
              >
                Hủy
              </button>
              <button
                onClick={handleUpdateNotes}
                disabled={notesLoading || !notes.trim()}
                className={`px-6 py-2 rounded-lg transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed ${
                  notes.trim() && !notesLoading
                    ? "bg-orange-500 text-white hover:bg-orange-600"
                    : "bg-gray-300 text-gray-500 cursor-not-allowed"
                }`}
              >
                {notesLoading
                  ? "Đang cập nhật..."
                  : selectedBookingForNotes.notes
                  ? "Cập Nhật"
                  : "Thêm Ghi Chú"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default RoomsManagement;
