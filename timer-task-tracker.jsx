import React, { useState, useEffect, useRef } from 'react';

export default function TimerTaskApp() {
  const [tasks, setTasks] = useState([]);
  const [timers, setTimers] = useState([]);
  const [newTask, setNewTask] = useState('');
  const [timerInput, setTimerInput] = useState('');
  const [activeTab, setActiveTab] = useState('tasks');
  const audioRef = useRef(null);

  useEffect(() => {
    const savedTasks = localStorage.getItem('tasks');
    const savedTimers = localStorage.getItem('timers');
    if (savedTasks) setTasks(JSON.parse(savedTasks));
    if (savedTimers) setTimers(JSON.parse(savedTimers));
  }, []);

  useEffect(() => {
    localStorage.setItem('tasks', JSON.stringify(tasks));
  }, [tasks]);

  useEffect(() => {
    localStorage.setItem('timers', JSON.stringify(timers));
  }, [timers]);

  useEffect(() => {
    const interval = setInterval(() => {
      setTimers(prevTimers =>
        prevTimers.map(timer => {
          if (timer.running && timer.remaining > 0) {
            const updated = { ...timer, remaining: timer.remaining - 1 };
            if (updated.remaining === 0) {
              playSound();
            }
            return updated;
          }
          return timer;
        })
      );
    }, 1000);
    return () => clearInterval(interval);
  }, []);

  const playSound = () => {
    const audioContext = new (window.AudioContext || window.webkitAudioContext)();
    const oscillator = audioContext.createOscillator();
    const gainNode = audioContext.createGain();
    oscillator.connect(gainNode);
    gainNode.connect(audioContext.destination);
    oscillator.frequency.value = 800;
    oscillator.type = 'sine';
    gainNode.gain.setValueAtTime(0.3, audioContext.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.5);
    oscillator.start(audioContext.currentTime);
    oscillator.stop(audioContext.currentTime + 0.5);
  };

  const addTask = () => {
    if (newTask.trim()) {
      setTasks([...tasks, { id: Date.now(), text: newTask, completed: false }]);
      setNewTask('');
    }
  };

  const toggleTask = (id) => {
    setTasks(tasks.map(task => task.id === id ? { ...task, completed: !task.completed } : task));
  };

  const deleteTask = (id) => {
    setTasks(tasks.filter(task => task.id !== id));
  };

  const addTimer = () => {
    const seconds = parseInt(timerInput);
    if (seconds > 0) {
      setTimers([...timers, { id: Date.now(), remaining: seconds, running: true, label: timerInput }]);
      setTimerInput('');
    }
  };

  const toggleTimer = (id) => {
    setTimers(timers.map(timer => timer.id === id ? { ...timer, running: !timer.running } : timer));
  };

  const deleteTimer = (id) => {
    setTimers(timers.filter(timer => timer.id !== id));
  };

  const formatTime = (seconds) => {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    if (h > 0) return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
    return `${m}:${s.toString().padStart(2, '0')}`;
  };

  const completedCount = tasks.filter(t => t.completed).length;

  return (
    <div style={{ background: 'var(--color-background-primary)', minHeight: '100vh', padding: '1.5rem 0' }}>
      <div style={{ maxWidth: '600px', margin: '0 auto', padding: '0 1.5rem' }}>
        <div style={{ display: 'flex', gap: '1rem', marginBottom: '2rem', borderBottom: '0.5px solid var(--color-border-tertiary)', paddingBottom: '1rem' }}>
          <button
            onClick={() => setActiveTab('tasks')}
            style={{
              background: activeTab === 'tasks' ? 'var(--color-background-secondary)' : 'transparent',
              border: '0.5px solid var(--color-border-tertiary)',
              padding: '0.5rem 1rem',
              borderRadius: 'var(--border-radius-md)',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: '500',
              color: 'var(--color-text-primary)',
              transition: 'all 0.2s'
            }}
          >
            <i className="ti ti-checkbox" style={{ marginRight: '6px', fontSize: '16px' }} aria-hidden="true"></i>
            Tasks
          </button>
          <button
            onClick={() => setActiveTab('timers')}
            style={{
              background: activeTab === 'timers' ? 'var(--color-background-secondary)' : 'transparent',
              border: '0.5px solid var(--color-border-tertiary)',
              padding: '0.5rem 1rem',
              borderRadius: 'var(--border-radius-md)',
              cursor: 'pointer',
              fontSize: '14px',
              fontWeight: '500',
              color: 'var(--color-text-primary)',
              transition: 'all 0.2s'
            }}
          >
            <i className="ti ti-clock" style={{ marginRight: '6px', fontSize: '16px' }} aria-hidden="true"></i>
            Timers
          </button>
        </div>

        {activeTab === 'tasks' && (
          <div>
            <div style={{ marginBottom: '1.5rem' }}>
              <div style={{ display: 'flex', gap: '8px', marginBottom: '1rem' }}>
                <input
                  type="text"
                  value={newTask}
                  onChange={(e) => setNewTask(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && addTask()}
                  placeholder="Add a new task..."
                  style={{ flex: 1, padding: '0.625rem', borderRadius: 'var(--border-radius-md)', border: '0.5px solid var(--color-border-tertiary)', fontSize: '14px' }}
                />
                <button
                  onClick={addTask}
                  style={{
                    background: 'var(--color-background-info)',
                    border: 'none',
                    padding: '0.625rem 1rem',
                    borderRadius: 'var(--border-radius-md)',
                    cursor: 'pointer',
                    color: 'var(--color-text-info)',
                    fontWeight: '500',
                    fontSize: '14px'
                  }}
                >
                  <i className="ti ti-plus" aria-hidden="true"></i>
                </button>
              </div>
              {tasks.length > 0 && (
                <div style={{ fontSize: '13px', color: 'var(--color-text-secondary)' }}>
                  {completedCount} of {tasks.length} completed
                </div>
              )}
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
              {tasks.length === 0 ? (
                <div style={{ textAlign: 'center', padding: '2rem 1rem', color: 'var(--color-text-secondary)', fontSize: '14px' }}>
                  <i className="ti ti-inbox" style={{ fontSize: '32px', display: 'block', marginBottom: '8px', opacity: 0.5 }} aria-hidden="true"></i>
                  No tasks yet. Add one to get started!
                </div>
              ) : (
                tasks.map(task => (
                  <div
                    key={task.id}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '12px',
                      padding: '1rem',
                      background: 'var(--color-background-secondary)',
                      borderRadius: 'var(--border-radius-md)',
                      border: '0.5px solid var(--color-border-tertiary)',
                      transition: 'all 0.2s'
                    }}
                  >
                    <input
                      type="checkbox"
                      checked={task.completed}
                      onChange={() => toggleTask(task.id)}
                      style={{ cursor: 'pointer', width: '18px', height: '18px' }}
                    />
                    <span
                      style={{
                        flex: 1,
                        textDecoration: task.completed ? 'line-through' : 'none',
                        color: task.completed ? 'var(--color-text-secondary)' : 'var(--color-text-primary)',
                        fontSize: '14px'
                      }}
                    >
                      {task.text}
                    </span>
                    <button
                      onClick={() => deleteTask(task.id)}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        cursor: 'pointer',
                        color: 'var(--color-text-secondary)',
                        padding: '4px',
                        display: 'flex',
                        alignItems: 'center'
                      }}
                    >
                      <i className="ti ti-trash" style={{ fontSize: '16px' }} aria-hidden="true"></i>
                    </button>
                  </div>
                ))
              )}
            </div>
          </div>
        )}

        {activeTab === 'timers' && (
          <div>
            <div style={{ marginBottom: '1.5rem' }}>
              <div style={{ display: 'flex', gap: '8px' }}>
                <input
                  type="number"
                  value={timerInput}
                  onChange={(e) => setTimerInput(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && addTimer()}
                  placeholder="Seconds..."
                  style={{ flex: 1, padding: '0.625rem', borderRadius: 'var(--border-radius-md)', border: '0.5px solid var(--color-border-tertiary)', fontSize: '14px' }}
                  min="1"
                />
                <button
                  onClick={addTimer}
                  style={{
                    background: 'var(--color-background-success)',
                    border: 'none',
                    padding: '0.625rem 1rem',
                    borderRadius: 'var(--border-radius-md)',
                    cursor: 'pointer',
                    color: 'var(--color-text-success)',
                    fontWeight: '500',
                    fontSize: '14px'
                  }}
                >
                  <i className="ti ti-plus" aria-hidden="true"></i>
                </button>
              </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
              {timers.length === 0 ? (
                <div style={{ textAlign: 'center', padding: '2rem 1rem', color: 'var(--color-text-secondary)', fontSize: '14px' }}>
                  <i className="ti ti-hourglass-empty" style={{ fontSize: '32px', display: 'block', marginBottom: '8px', opacity: 0.5 }} aria-hidden="true"></i>
                  No timers running. Create one to start!
                </div>
              ) : (
                timers.map(timer => (
                  <div
                    key={timer.id}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '12px',
                      padding: '1rem',
                      background: timer.remaining === 0 ? 'var(--color-background-warning)' : 'var(--color-background-secondary)',
                      borderRadius: 'var(--border-radius-md)',
                      border: '0.5px solid var(--color-border-tertiary)',
                      transition: 'all 0.2s'
                    }}
                  >
                    <button
                      onClick={() => toggleTimer(timer.id)}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        cursor: 'pointer',
                        color: 'var(--color-text-primary)',
                        padding: '4px',
                        display: 'flex',
                        alignItems: 'center',
                        fontSize: '18px'
                      }}
                    >
                      <i className={`ti ${timer.running ? 'ti-player-pause' : 'ti-player-play'}`} aria-hidden="true"></i>
                    </button>
                    <div style={{ flex: 1 }}>
                      <div style={{ fontSize: '18px', fontWeight: '500', color: 'var(--color-text-primary)', fontVariantNumeric: 'tabular-nums' }}>
                        {formatTime(timer.remaining)}
                      </div>
                    </div>
                    <button
                      onClick={() => deleteTimer(timer.id)}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        cursor: 'pointer',
                        color: 'var(--color-text-secondary)',
                        padding: '4px',
                        display: 'flex',
                        alignItems: 'center'
                      }}
                    >
                      <i className="ti ti-x" style={{ fontSize: '16px' }} aria-hidden="true"></i>
                    </button>
                  </div>
                ))
              )}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
